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

sub check_remote {
  my $self = shift;

  my (@commits) = $self->git->rev_list( { -not => $self->branch }, $self->remote_branch );

  return unless @commits;

  my $number_of_commits = scalar @commits;
  my @selected_commits  = splice @commits, 0, $self->report_commits;
  my $commits_displayed = scalar @selected_commits;

  my $message = <<'EOF';
  %d commits visible upstream on '%s' not visible on '%s'.
  Either merge with '%s', rebase on '%s', or anihilate upstream with 'git push -f '
  %d most recent commits:
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

