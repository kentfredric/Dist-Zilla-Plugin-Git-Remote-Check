use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Check;

# FILENAME: Check.pm
# CREATED: 13/10/11 10:52:07 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Check a remote branch is not ahead of a local one

use Moose::Role;

=requires C<git>

Must return a L<Git::Wrapper> or compatible instance.

Available from:

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository>

=back

=cut

requires 'git';

=requires C<remote_branch>

Must return a string value of a fully qualified branch name, e.g.: C<origin/master>

Available from:

=over 4

=item * L<Dist::Zilla::Role::Git::Remote::Branch>

=back

=cut

requires 'remote_branch';

=requires C<branch>

Must be implemented by the consuming plugin. ( Presently I know of no roles that provide this method ).

Must return a string value of a branch name, e.g.: C<master>

=cut

requires 'branch';

=requires C<current_branch>

Must return the name (String) of the branch we are currently on, or return false if we are not on a branch.

Must be one of the branches listed by C<git branch>

=param C<report_commits>

=cut

=method C<report_commits>

=cut

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

=param  C<skip_if_not_current>

=cut

=method C<skip_if_not_current>

=cut

has 'skip_if_not_current' => ( isa => 'Bool', is => 'rw', default => undef );

=method C<is_current_branch>

=cut

sub is_current_branch {
  my $self = shift;
  return ( $self->branch eq $self->current_branch );
}

=method C<should_skip>

=cut

sub should_skip {
  my $self = shift;
  return unless $self->skip_if_not_current;
  return if $self->is_current_branch;
  return 1;
}

=method C<check_remote>

=cut

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

