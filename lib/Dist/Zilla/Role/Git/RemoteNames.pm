
use strict;
use warnings;

package Dist::Zilla::Role::Git::RemoteNames;
BEGIN {
  $Dist::Zilla::Role::Git::RemoteNames::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::RemoteNames::VERSION = '0.2.0'; # TRIAL
}

# ABSTRACT: Query a list of remotes from C<Git>

use Moose::Role;



requires 'log_fatal';
requires 'git';

has 'remote_names' => (
  isa        => 'ArrayRef[ Str ]',
  is         => 'rw',
  lazy_build => 1,
  traits     => [qw( Array )],
  handles    => { _has_remote_name => 'first' },
  init_arg   => undef,
);


sub has_remote_name {
  my ( $self, $remote_name ) = @_;
  return $self->_has_remote_name( sub { $_ eq $remote_name } );
}


sub get_valid_remote_name {
  my ( $self, $remote_name ) = @_;
  return $remote_name if $self->has_remote_name($remote_name);

  require Data::Dump;

  my $msg = qq[Git reports remote name '%s' does not exist.\n Remotes: %s];

  return $self->log_fatal( [ $msg, $remote_name, Data::Dump::dump( $self->remote_names ), ] );
}

sub _build_remote_names {
    my ( $self, ) = @_;
    return [ $self->git->remote ]
}

no Moose::Role;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::Git::RemoteNames - Query a list of remotes from C<Git>

=head1 VERSION

version 0.2.0

=head1 METHODS

=head2 C<has_remote_name>

    if ( $self->has_remote_name( $name ) ) {

    }

Returns true if C<git> reports C<$name> is a remote name that exists.

=head2 C<get_valid_remote_name>

    my $remote = $self->get_valid_remote_name( $remotename );

Returns C<$remotename> as long as C<$remotename> is a valid remote according to C<git>

Raises a fatal error otherwise.

=head1 COMPOSITION

Recommended application order if using this role:

    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::RemoteNames";

=head1 REQUIRED METHODS

=head2 C<log_fatal>

=head2 C<git>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::RemoteNames",
    "interface":"role"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
