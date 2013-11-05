use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository;

# FILENAME: LocalRepository.pm
# CREATED: 12/10/11 16:47:31 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: A plugin which works with a local git repository as its Dist::Zilla source.

use Moose::Role;

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::LocalRepository",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

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

=head1 DESCRIPTION

This role is for all plugins that need to work with a local repository that is from Git, and assumes the git directory is the project root.

Applying this role gives you a "git" method on your plugin, that will give you a Git::Wrapper instance for the project.


    package Dist::Zilla::Plugin::Mine;
    use Moose;

    ...

    with 'Dist::Zilla::Role::Git::LocalRepository';

    sub some_phase {
        $_[0]->git-> ...
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

