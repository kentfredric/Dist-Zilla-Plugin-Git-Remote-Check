use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Update;

# FILENAME: Update.pm
# CREATED: 12/10/11 21:44:42 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update tracking data for a remote repository

use Moose::Role;

=requires C<git>

=requires C<remote>

=requires C<log>

=cut

requires 'git';
requires 'remote';
requires 'log';

=param C<do_update>

=cut

=method C<do_update>

=cut

has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );

=method C<remote_update>

=cut

sub remote_update {

  my $self = shift;
  return unless $self->do_update;

  my $remote = $self->remote;

  $self->log( [ q[Updating remote '%s'], $remote ] );

  my (@out) = $self->git->remote( '--verbose', 'update', $remote );

  $self->log_debug("[git] $_") for @out;

  return 1;
}

no Moose::Role;

1;

