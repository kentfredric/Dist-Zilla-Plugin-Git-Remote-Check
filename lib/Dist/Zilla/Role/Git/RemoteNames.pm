
use strict;
use warnings;

package Dist::Zilla::Role::Git::RemoteNames;
BEGIN {
  $Dist::Zilla::Role::Git::RemoteNames::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::RemoteNames::VERSION = '0.1.3';
}

use Moose::Role;


requires 'log_fatal';

# requires 'git';

with "Dist::Zilla::Role::Git::LocalRepository";

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

sub _build_remote_names { return [ $_[0]->git->remote ] }

no Moose::Role;

1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::Git::RemoteNames

=head1 VERSION

version 0.1.3

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::RemoteNames",
    "interface":"role",
    "does":[
        "Dist::Zilla::Role::Git::LocalRepository"
    ]
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
