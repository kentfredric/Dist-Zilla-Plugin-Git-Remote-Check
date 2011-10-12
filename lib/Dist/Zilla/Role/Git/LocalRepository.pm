use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository;

# FILENAME: LocalRepository.pm
# CREATED: 12/10/11 16:47:31 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: A plugin which works with a local git repository as its Dist::Zilla source.

use Moose::Role;

requires 'zilla';

has 'git' => (
  isa        => 'Object',
  is         => 'ro',
  lazy_build => 1,
  init_arg   => undef,
);

sub _build_git {
  require Git::Repository;
  my $self = shift;
  return Git::Repository->new( $self->zilla->root );
}

no Moose::Role;
1;

