use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Update;

# FILENAME: Update.pm
# CREATED: 12/10/11 21:44:42 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update tracking data for a remote repository

use Moose::Role;


=requires C<log>

Expected to take parameters as follows:

  ->log( [ 'FormatString %s' , $formatargs ] )

Available from:

=over 4

=item * L<Dist::Zilla::Role::Plugin>

=back

=cut

requires 'log';

=param C<do_update>

Boolean: Specify whether or not the L</do_update> method does anything.

Defaults to 1 ( true ), and setting it to a false value will disable updating.

=cut

=method C<do_update>

Boolean: Returns whether the consuming plugin should perform updates.

Normally returns 1 ( true ) unless specified otherwise.

=cut

has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );

=method C<remote_update>

Calls C<git remote update $remote> when triggered, if C<do_update> is true.

=cut

sub remote_update {

  my $self = shift;
  return unless $self->do_update;

  my $remote = $self->remote_name;

  $self->log( [ q[Updating remote '%s'], $remote ] );

  my (@out) = $self->git->remote( '--verbose', 'update', $remote );

  $self->log_debug("[git] $_") for @out;

  return 1;
}

no Moose::Role;

1;

