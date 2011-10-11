use strict;
use warnings;

package Dist::Zilla::Plugin::Git::Check::Remote;

# ABSTRACT: Ensure no pending commits on a remote branch.

use Moose;
with 'Dist::Zilla::Role::BeforeBuild';

=head1 SYNOPSIS

  [Git::Check::Remote]
  branch = master        ; Str  default = master
  remote_name   = origin ; Str  default = origin
  remote_branch = master ; Str  default = ->branch()
  report_commits = 5     ; Int  default = 5
  do_update      = 1     ; Bool default = 1

=cut

has '_git' => ( is => 'rw', lazy_build => 1 );
sub _build__git { my $self = shift; require Git::Wrapper; return Git::Wrapper->new( $self->zilla->root ); }

has 'branch' => ( isa => 'Str', is => 'rw', default => 'master' );

has 'remote_name' => ( isa => 'Str', is => 'rw', default => 'origin' );

has 'remote_branch' => ( isa => 'Str', is => 'rw', lazy_build => 1 );
sub _build_remote_branch { my $self = shift; return $self->branch; }

has '_remote' => ( isa => 'Str', is => 'rw', lazy_build => 1 );
sub _build__remote { my $self = shift; return $self->remote_name . '/' . $self->remote_branch; }

has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );

has '_remotes' => (
  isa        => 'ArrayRef',
  is         => 'rw',
  lazy_build => 1,
  traits     => [qw( Array )],
  handles    => { has_remote => 'first', }
);
sub _build__remotes { my $self = shift; return [ $self->_git->remote ]; }

has 'report_commits' => ( isa => 'Int', is => 'rw', default => 5 );

sub _update_remote {
  my $self = shift;
  unless ( $self->has_remote( $self->remote_name ) ) {
    require Data::Dump;
    $self->log_fatal(
      [
        qq[Cannot update remote name '%s', git reports it does not exist.\n Remotes: %s],
        $self->remote_name, Data::Dump::dump( $self->_remotes ),
      ]
    );
  }
  $self->_git->remote( 'update', $self->remote_name );
}

sub _incomming_commits {
  my $self = shift;
  return $self->_git->rev_list( { -not => $self->branch }, $self->_remote );
}

sub _check_remote {
  my $self    = shift;
  my @commits = @{ $self->_incomming_commits };

  return unless @commits;

  my $want_commits =
      ( ( scalar @commits ) < $self->report_commits )
    ? ( scalar @commits )
    : $self->report_commits;

  my @selected_commits = @commits[ 0, $want_commits - 1 ];

  require Data::Dump;

  $self->log_fatal(
    [
      qq[ %d commits visible upstream on '%s' not visible on '%s'. \n]
        . qq[ Either merge with '%s', rebase on '%s', or anihilate upstream with 'git push -f '\n]
        . qq[ %d most recent commits: \n] . qq[ %s],
      scalar @commits,
      $self->_remote,
      $self->branch,
      $self->_remote,
      $self->_remote,
      $want_commits,
      Data::Dump::dump( \@selected_commits ),
    ]
  );

}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
