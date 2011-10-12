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
  when           = beforerelease ; enum('beforebuild','beforerelease')

=cut

with 'Dist::Zilla::Role::Git::LocalRepository',    #
  'Dist::Zilla::Role::Git::Remote',                #
  'Dist::Zilla::Role::Git::Remote::Branch',        #
  ;

has 'branch' => ( isa => 'Str', is => 'rw', default => 'master' );

has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );

has 'report_commits' => ( isa => 'Int', is => 'rw', default => 5 );

sub _update_remote {
  my $self = shift;

  if ( $self->has_remote( $self->remote_name ) ) {
    $self->git->remote( 'update', $self->remote_name );
    return 1;
  }

  $self->log_fatal(
    [
      qq[Cannot update remote name '%s', git reports it does not exist.\n Remotes: %s],
      $self->remote_name, $self->_dump( $self->_remotes ),
    ]
  );

  return;

}

sub _incomming_commits {
  my $self = shift;
  return $self->git->rev_list( { -not => $self->branch }, $self->_remote );
}

sub _check_remote {
  my $self = shift;

  my @commits = @{ $self->_incomming_commits };

  return unless @commits;

  my $number_of_commits = scalar @commits;
  my @selected_commits  = splice @commits, 0, $self->report_commits;
  my $commits_displayed = scalar @selected_commits;

  $self->log_fatal(
    [
      qq[ %d commits visible upstream on '%s' not visible on '%s'. \n]
        . qq[ Either merge with '%s', rebase on '%s', or anihilate upstream with 'git push -f '\n]
        . qq[ %d most recent commits: \n] . qq[ %s],
      $number_of_commits,
      $self->_remote,
      $self->branch,
      $self->_remote,
      $self->_remote,
      $commits_displayed,
      $self->_dump( \@selected_commits ),
    ]
  );

}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
