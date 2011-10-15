use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository;

# FILENAME: LocalRepository.pm
# CREATED: 12/10/11 16:47:31 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: A plugin which works with a local git repository as its Dist::Zilla source.

use Moose::Role;

=head1 SYNOPSIS

  package Foo;

  use Moose;
  with 'Dist::Zilla::Role::BeforeRelease';
  with 'Dist::Zilla::Role::Git::LocalRepository';

  sub before_release {
    my $self = shift;
    print for $self->git->version;
  }

=cut

=requires zilla

Available from:

=over 4

=item * L<Dist::Zilla::Role::Plugin>

=back

=cut

requires 'zilla';

=method git

Returns a L<Git::Wrapper> instance representing the repository
of the current L<Dist::Zilla> projects' root.

=cut

has 'git' => (
  isa        => 'Object',
  is         => 'ro',
  lazy_build => 1,
  init_arg   => undef,
);

sub _build_git {
  require Git::Wrapper;
  my $self = shift;
  return Git::Wrapper->new( $self->zilla->root );
}

no Moose::Role;
1;

