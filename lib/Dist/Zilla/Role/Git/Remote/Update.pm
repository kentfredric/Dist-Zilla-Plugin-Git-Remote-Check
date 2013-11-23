use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Update;
BEGIN {
  $Dist::Zilla::Role::Git::Remote::Update::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::Remote::Update::VERSION = '0.2.0'; # TRIAL
}

# ABSTRACT: Update tracking data for a remote repository

use Moose::Role;


requires 'log';

requires 'log_debug';

requires 'git';

requires 'remote_name';



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

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::Git::Remote::Update - Update tracking data for a remote repository

=head1 VERSION

version 0.2.0

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

=head1 COMPOSITION

Recommended application order if using this role:

    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::RemoteNames";
    with "Dist::Zilla::Role::Git::RemoteName";
    with "Dist::Zilla::Role::Git::Remote::Update";

=head1 REQUIRED METHODS

=head2 C<log>

=head2 C<log_debug>

=head2 C<git>

=head2 C<remote_name>

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
