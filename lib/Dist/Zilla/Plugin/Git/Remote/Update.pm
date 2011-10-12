use strict;
use warnings;

package Dist::Zilla::Plugin::Git::Remote::Update;
BEGIN {
  $Dist::Zilla::Plugin::Git::Remote::Update::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Plugin::Git::Remote::Update::VERSION = '0.1.0'; # TRIAL
}

# FILENAME: Update.pm
# CREATED: 13/10/11 05:17:02 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Update a remote with Git before release.

use Moose;

with 'Dist::Zilla::Role::BeforeRelease';
with 'Dist::Zilla::Role::Git::LocalRepository';
with 'Dist::Zilla::Role::Git::Remote';
with 'Dist::Zilla::Role::Git::Remote::Update';


sub before_release {
  my $self = shift;
  $self->remote_update;
  return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;


__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::Git::Remote::Update - Update a remote with Git before release.

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

This Module is mostly intended to be used in conjunction with other things,
and won't on its own provide a lot of useful results.

Having this in your configuration will effectively cause git to run C<git remote update $remotename>
before you release, and remotes don't usually have any impact on things in the rest of DZil-land.

  [Git::Remote::Update]
  ; Provided by Dist::Zilla::Role::Git::Remote 
  ; String
  ; The name of the remote to update.
  ; Must exist in Git.
  ; default is 'origin'
  remote_name = origin

  ; Provided by Dist::Zilla::Role::Git::Remote::Update
  ; Boolean
  ; turn updating on/off
  ; default is 'on' ( 1 / true )
  do_update = 1

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

