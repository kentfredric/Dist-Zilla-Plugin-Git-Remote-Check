use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Update;

# FILENAME: Update.pm
# CREATED: 12/10/11 21:44:42 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update tracking data for a remote repository

use Moose::Role;

requires 'git';
requires 'remote';

has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );

sub remote_update {

  my $self = shift;
  return unless $self->do_update;

  my $remote = $self->remote;

  $self->git->remote( 'update', $remote );

  1;
}

no Moose::Role;

1;

