use strict;
use warnings;
package Dist::Zilla::Plugin::Git::Remote::Update;
# FILENAME: Update.pm
# CREATED: 13/10/11 05:17:02 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update a remote with Git before release.

use Moose;

with 'Dist::Zilla::Role::BeforeRelease', 
     'Dist::Zilla::Role::Git::LocalRepository',
     'Dist::Zilla::Role::Git::Remote',
     'Dist::Zilla::Role::Git::Remote::Update';

=head1 SYNOPSIS

This Module is mostly intended to be used in conjuction with other things,
and won't on its own provide a lot of useful results.

Having this in your configuration will effectively cause git to run C<git remote update $remotename>
before you release, and remotes don't usually have any impact on things in the rest of DZil-land.

  [Git::Remote::Update]
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

sub before_release {
  my $self = shift;
  $self->remote_update;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;


