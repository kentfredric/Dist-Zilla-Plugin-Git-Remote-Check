use strict;
use warnings;

package Dist::Zilla::Role::Git::RemoteName;
BEGIN {
  $Dist::Zilla::Role::Git::RemoteName::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::RemoteName::VERSION = '0.2.0'; # TRIAL
}

# ABSTRACT: Git Remote specification and validation for plugins.

use Moose::Role;



requires 'log_fatal';

requires 'get_valid_remote_name';


sub remote_name {
  my ($self) = @_;
  return $self->get_valid_remote_name( $self->_remote_name );
}


has '_remote_name' => (
  isa      => 'Str',
  is       => 'rw',
  default  => 'origin',
  init_arg => 'remote_name',
);

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::Git::RemoteName - Git Remote specification and validation for plugins.

=head1 VERSION

version 0.2.0

=head1 PARAMETERS

=head2 C<remote_name>

String.

The name of the C<git remote> you want to refer to.

Defaults to C<origin>

=head1 METHODS

=head2 C<remote_name>

If a consuming package specifies a valid value via C<remote_name>,
this method will validate the existence of that remote in the current Git repository.

If specified remote does not exist, a fatal log event is triggered.

=head1 COMPOSITION

Recommended application order if using this role:

    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::RemoteNames";
    with "Dist::Zilla::Role::Git::RemoteName";

=head1 REQUIRED METHODS

=head2 C<log_fatal>

Expected to take parameters as follows:

  ->log_fatal( [ 'FormatString %s' , $formatargs ] )

Expected to halt execution ( throw an exception ) when called.

Available from:

=over 4

=item * L<Dist::Zilla::Role::Plugin>

=back

=head2 C<get_valid_remote_name>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::RemoteName",
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
