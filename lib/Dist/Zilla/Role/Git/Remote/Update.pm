use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Update;
BEGIN {
  $Dist::Zilla::Role::Git::Remote::Update::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::Remote::Update::VERSION = '0.1.0'; # TRIAL
}

# FILENAME: Update.pm
# CREATED: 12/10/11 21:44:42 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update tracking data for a remote repository

use Moose::Role;

requires 'git';
requires 'remote';
requires 'log';

has 'do_update' => ( isa => 'Bool', is => 'rw', default => 1 );

sub remote_update {

  my $self = shift;
  return unless $self->do_update;

  my $remote = $self->remote;

  $self->log([q[Updating remote '%s'], $remote ]);

  my ( @out ) = $self->git->remote( '--verbose','update', $remote );

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

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

