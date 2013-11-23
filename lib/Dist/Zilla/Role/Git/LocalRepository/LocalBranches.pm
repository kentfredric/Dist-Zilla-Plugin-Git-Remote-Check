use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::LocalBranches;

# ABSTRACT: Enumerate all available local branches as branch ↔ C<SHA1> mappings.

use Moose::Role;

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::LocalRepository::LocalBranches",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

=head1 COMPOSITION

Recommended application order if using this role:

    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";

=requires C<git>

Must be a Git::Wrapper instance.

Suggests L<Dist::Zilla::Role::Git::LocalRepository>

=cut

requires 'git';

=param C<local_branches>

=cut

=method C<local_branches>

Returns a map from C<git> of

    { branch_name => SHA1 }

=cut

has local_branches => (
  isa        => 'HashRef',
  is         => 'rw',
  lazy_build => 1,
);

=p_method _build_local_branches

Builder for L</local_branches>

=cut

sub _build_local_branches {
  my ($self) = @_;
  my @branch_shas = $self->git->rev_parse('--branches');
  my %branches;

  for my $sha (@branch_shas) {
    my $label = $self->git->name_ref( '--name-only', '--refs', 'refs/heads/*', $sha );
    $branches{$label} = $sha;
  }
  return \%branches;
}

no Moose::Role;

1;
