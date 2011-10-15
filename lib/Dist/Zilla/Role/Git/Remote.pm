use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote;

# FILENAME: Remote.pm
# CREATED: 12/10/11 17:12:13 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Git Remote specification and validation for plugins.

use Moose::Role;

=requires C<git>

Must return a L<Git::Wrapper> or compatible instance.

Available from:

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository>

=back

=cut

requires 'git';

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

=method C<remote>

If a consuming package specifies a valid value via C<remote_name>, 
this method will validate the existence of that remote in the current Git repository.

If specified remote does not exist, a fatal log event is triggered.

=cut

sub remote {
  my ($self) = @_;
  $self->_assert_valid_remote;
  return $self->_remote_name;
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

has '_remotes' => (
  isa        => 'ArrayRef[ Str ]',
  is         => 'rw',
  lazy_build => 1,
  traits     => [qw( Array )],
  handles    => { _has_remote => 'first' },
  init_arg   => undef,
);

sub _build__remotes {
  my $self = shift;
  return [ $self->git->remote ];
}

sub _remote_valid {
  my $self = shift;
  return $self->_has_remote( sub { $_ eq $self->_remote_name } );
}

sub _assert_valid_remote {
  my $self = shift;
  return if $self->_remote_valid;
  require Data::Dump;

  my $msg = qq[Git reports remote name '%s' does not exist.\n Remotes: %s];

  return $self->log_fatal( [ $msg, $self->_remote_name, Data::Dump::dump( $self->_remotes ), ] );

}

no Moose::Role;
1;

