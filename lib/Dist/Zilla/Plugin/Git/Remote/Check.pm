use strict;
use warnings;

package Dist::Zilla::Plugin::Git::Remote::Check;

# ABSTRACT: Ensure no pending commits on a remote branch before release

use Moose;


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

with 'Dist::Zilla::Role::BeforeRelease';
with 'Dist::Zilla::Role::Git::LocalRepository';
with 'Dist::Zilla::Role::Git::Remote';
with 'Dist::Zilla::Role::Git::Remote::Branch';
with 'Dist::Zilla::Role::Git::Remote::Update';

has 'branch' => ( isa => 'Str', is => 'rw', default => 'master' );

with 'Dist::Zilla::Role::Git::Remote::Check';

has '+_remote_branch' => ( default => sub { shift->branch } );

sub before_release {
  my $self = shift;
  $self->remote_update;
  $self->check_remote;
  return 1;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
