use strict;
use warnings;

package Dist::Zilla::Role::Git::RemoteName;

# ABSTRACT: Git Remote specification and validation for plugins.

use Moose::Role;


=requires C<log_fatal>

Expected to take parameters as follows:

  ->log_fatal( [ 'FormatString %s' , $formatargs ] )

Expected to halt execution ( throw an exception ) when called.

Available from:

=over 4

=item * L<Dist::Zilla::Role::Plugin>

=back

=cut

requires 'log_fatal';

=method C<remote_name>

If a consuming package specifies a valid value via C<remote_name>, 
this method will validate the existence of that remote in the current Git repository.

If specified remote does not exist, a fatal log event is triggered.

=cut

sub remote_name {
  my ($self) = @_;
  return $self->get_valid_remote_name( $self->_remote_name );
}

=param C<remote_name>

String.

The name of the C<git remote> you want to refer to.

Defaults to C<origin>

=cut

has '_remote_name' => (
  isa      => 'Str',
  is       => 'rw',
  default  => 'origin',
  init_arg => 'remote_name',
);

no Moose::Role;
1;

