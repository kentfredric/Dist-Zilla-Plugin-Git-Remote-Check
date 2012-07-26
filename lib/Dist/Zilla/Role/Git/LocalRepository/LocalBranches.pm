use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::LocalBranches;
use Moose::Role;

requires 'git';

has local_branches => (
  isa        => 'HashRef',
  is         => 'rw',
  lazy_build => 1,
);

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
