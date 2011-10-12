use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Check;

# FILENAME: Check.pm
# CREATED: 13/10/11 10:52:07 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Check a remote branch is not ahead of a local one

use Moose::Role;

requires 'git';
requires 'remote_branch';
requires 'branch';

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

}

no Moose::Role;
1;

