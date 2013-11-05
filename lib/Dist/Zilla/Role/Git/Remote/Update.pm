use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Update;
BEGIN {
  $Dist::Zilla::Role::Git::Remote::Update::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::Remote::Update::VERSION = '0.1.3';
}

# FILENAME: Update.pm
# CREATED: 12/10/11 21:44:42 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update tracking data for a remote repository

use Moose::Role;


requires 'log';

requires 'remote_name';

requires 'git';

requires 'log_debug';



has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );


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

__END__

=pod

=head1 NAME

Dist::Zilla::Role::Git::Remote::Update - Update tracking data for a remote repository

=head1 VERSION

version 0.1.3

=head1 PARAMETERS

=head2 C<do_update>

Boolean: Specify whether or not the L</do_update> method does anything.

Defaults to 1 ( true ), and setting it to a false value will disable updating.

=head1 METHODS

=head2 C<do_update>

Boolean: Returns whether the consuming plugin should perform updates.

Normally returns 1 ( true ) unless specified otherwise.

=head2 C<remote_update>

Calls C<git remote update $remote> when triggered, if C<do_update> is true.

=head1 REQUIRED METHODS

=head2 C<log>

Expected to take parameters as follows:

  ->log( [ 'FormatString %s' , $formatargs ] )

Available from:

=over 4

=item * L<Dist::Zilla::Role::Plugin>

=back

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::Remote::Update",
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
