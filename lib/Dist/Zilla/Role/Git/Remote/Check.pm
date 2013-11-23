use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Check;
BEGIN {
  $Dist::Zilla::Role::Git::Remote::Check::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::Remote::Check::VERSION = '0.1.3';
}

# FILENAME: Check.pm
# CREATED: 13/10/11 10:52:07 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Check a remote branch is not ahead of a local one

use Moose::Role;


requires 'branch';
requires 'current_branch';
requires 'git';
requires 'log';
requires 'log_fatal';
requires 'remote_branch';



has 'report_commits' => ( isa => 'Int', is => 'rw', default => 5 );

sub _incomming_commits {
  my $self = shift;
  return ( $self->git->rev_list( '--oneline', $self->remote_branch, '--not', $self->branch, ) );
}

# this checks the inverse, ie: that local is *not* ahead of remote, only used for
# testing purposes.
sub _outgoing_commits {
  my $self = shift;

  # $self->log('[TESTING] Doing inverse check, making sure we\'re ahead');
  # $self->log([ '[TESTING] remote: %s  local: %s', $self->remote_branch, $self->branch ]);
  my (@commits) = $self->git->rev_list( '--oneline', $self->branch, '--not', $self->remote_branch );

  #  require Data::Dump;
  #  $self->log(['[TESTING] %s', Data::Dump::dump( \@commits ) ]);
  return @commits;
}



has 'skip_if_not_current' => ( isa => 'Bool', is => 'rw', default => undef );


sub is_current_branch {
  my $self = shift;
  return ( $self->branch eq $self->current_branch );
}


sub should_skip {
  my $self = shift;
  return unless $self->skip_if_not_current;
  return if $self->is_current_branch;
  return 1;
}


sub check_remote {
  my $self = shift;

  my (@commits) = $self->_incomming_commits;

  #my (@commits) = $self->_outgoing_commits;

  return unless @commits;

  my $number_of_commits = scalar @commits;
  my @selected_commits  = splice @commits, 0, $self->report_commits;
  my $commits_displayed = scalar @selected_commits;

  my $message = <<'EOF';
There are %d commits visible upstream on '%s' not visible on '%s'.
Either merge with '%s', rebase on '%s', or anihilate upstream with 'git push -f '
The %d most recent commits are:
 %s
EOF

  require Data::Dump;

  $self->log_fatal(
    [
      $message,
      ( $number_of_commits,   $self->remote_branch, $self->branch, ),
      ( $self->remote_branch, $self->remote_branch, ),
      ( $commits_displayed, ),
      ( Data::Dump::dump( \@selected_commits ), ),
    ]
  );

  return 1;
}

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::Git::Remote::Check - Check a remote branch is not ahead of a local one

=head1 VERSION

version 0.1.3

=head1 PARAMETERS

=head2 C<report_commits>

=head2 C<skip_if_not_current>

=head1 METHODS

=head2 C<report_commits>

=head2 C<skip_if_not_current>

=head2 C<is_current_branch>

=head2 C<should_skip>

=head2 C<check_remote>

=head1 COMPOSITION

Recommended application order if using this role:

    sub branch {

    }
    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";
    with "Dist::Zilla::Role::Git::LocalRepository::CurrentBranch";
    with "Dist::Zilla::Role::Git::RemoteNames";
    with "Dist::Zilla::Role::Git::RemoteName";
    with "Dist::Zilla::Role::Git::Remote::Branch";
    with "Dist::Zilla::Role::Git::Remote::Check";

=head1 REQUIRED METHODS

=head2 C<branch>

=head2 C<current_branch>

Must return the name (String) of the branch we are currently on, or return false if we are not on a branch.

Must be one of the branches listed by C<git branch>

=head2 C<log>

=head2 C<log_fatal>

=head2 C<remote_branch>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::Remote::Check",
    "interface":"role"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
