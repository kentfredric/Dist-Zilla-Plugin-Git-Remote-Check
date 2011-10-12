use strict;
use warnings;

package Dist::Zilla::Plugin::Git::Remote::Update::BeforeBuild;

# FILENAME: BeforeBuild.pm
# CREATED: 13/10/11 05:17:02 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update a remote with Git before build.

use Moose;

with 'Dist::Zilla::Role::BeforeBuild';
with 'Dist::Zilla::Role::Git::LocalRepository';
with 'Dist::Zilla::Role::Git::Remote';
with 'Dist::Zilla::Role::Git::Remote::Update';

=head1 SYNOPSIS

This Module is mostly intended to be used in conjuction with other things,
and won't on its own provide a lot of useful results.

Having this in your configuration will effectively cause git to run C<git remote update $remotename>
before you build, and remotes don't usually have any impact on things in the rest of DZil-land.

  [Git::Remote::Update::BeforeBuild]
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

=cut

sub before_build {
  my $self = shift;
  $self->remote_update;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

