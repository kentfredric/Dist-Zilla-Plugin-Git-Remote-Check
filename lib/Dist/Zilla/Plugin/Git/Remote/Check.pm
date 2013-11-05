use strict;
use warnings;

package Dist::Zilla::Plugin::Git::Remote::Check;

# ABSTRACT: Ensure no pending commits on a remote branch before release

use Moose;
use namespace::autoclean;

=head1 SYNOPSIS

  [Git::Remote::Check]
   ; Provided by Dist::Zilla::Role::Git::Remote
  ; String
  ; The name of the remote to update.
  ; Must exist in Git.
  ; default is 'origin'
  remote_name = origin

  ; Provided by Dist::Zilla::Role::Git::Remote::Update
  ; Boolean
  ; turn updating on/off
  ; default is 'on' ( 1 / true )
  do_update = 1

  ; Provided by Dist::Zilla::Role::Git::Remote::Branch
  ; String
  ; the name of the branch on the remote side to check against
  ; default is the same value us 'branch'
  remote_branch = master

  ; String
  ; the name of the branch on the local side to check.
  ; default is 'master'
  branch = master

  ; Provided by Dist::Zilla::Role::Git::Remote::Check;
  ; Int
  ; How many of the most recent commits to dump when we're behind upstream.
  ; default = 5
  report_commits = 5

=cut

=role C<Dist::Zilla::Role::BeforeRelease>

Causes this plugin to be executed during L<Dist::Zilla>'s "Before Re,ease" phase.
( L</before_release> )

=cut

with 'Dist::Zilla::Role::BeforeRelease';

=method C<before_release>

Executes code before releasing.

=over 4

=item 1.

Updates the L</remote> via L<Dist::Zilla::Role::Git::Remote::Update/remote_update>

=item 2.

Checks the L</remote> via L<Dist::Zilla::Role::Git::Remote::Check/check_remote>

=back

=cut

sub before_release {
  my $self = shift;
  return if $self->should_skip;
  $self->remote_update;
  $self->check_remote;
  return 1;
}

=role C<Dist::Zilla::Role::Git::Remote>

Provides a L</remote> method which always returns a validated C<remote> name,
optionally accepting it being specified manually to something other than
C<origin> via the parameter L</remote_name>

=method C<remote>

Returns a validated remote name. Configured via L</remote_name> parameter.

=cut

=param C<remote_name>

The name of the repository to use as specified in C<.git/config>.

Defaults to C<origin>, which is usually what you want.

=cut

with 'Dist::Zilla::Role::Git::Remote::Branch';

=role C<Dist::Zilla::Role::Git::Remote::Update>

Provides a L</remote_update> method which updates a L</remote> in L</git>

=method C<remote_update>

Performs C<git remote update $remote_name> on L</git> for the remote L</remote>

=param C<do_update>

A boolean value that specifies whether or not to execute the update.

Default value is C<1> / true.

=cut

with 'Dist::Zilla::Role::Git::Remote::Update';

=method C<branch>

The local branch to check against the remote one. Defaults to 'master'

=param C<branch>

The local branch to check against the remote one. Defaults to 'master'

=cut

has 'branch' => ( isa => Str =>, is => rw =>, default => master =>, );

=role C<Dist::Zilla::Role::Git::Remote::Check>

Provides L</check_remote> which compares L</branch> and L</remote_branch> and
asserts L</remote_branch> is not ahead of L</branch>

=method C<check_remote>

Compare L</branch> and L</remote_branch> making sure that L</branch> is the more
recent of the 2.

=param C<report_commits>

In the event the remote is ahead, this C<Int> dictates the maximum number of
commits to print to output.

Defaults to C<5>

=cut

with 'Dist::Zilla::Role::Git::Remote::Check';

has '+_remote_branch' => ( lazy => 1, default => sub { shift->branch } );

with 'Dist::Zilla::Role::Git::LocalRepository::LocalBranches';

with 'Dist::Zilla::Role::Git::LocalRepository::CurrentBranch';

__PACKAGE__->meta->make_immutable;
no Moose;

1;
