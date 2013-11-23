use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::LocalBranches;
BEGIN {
  $Dist::Zilla::Role::Git::LocalRepository::LocalBranches::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::LocalRepository::LocalBranches::VERSION = '0.2.0'; # TRIAL
}

# ABSTRACT: Enumerate all available local branches as branch ↔ C<SHA1> mappings.

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

__END__

=pod

=head1 NAME

Dist::Zilla::Role::Git::LocalRepository::LocalBranches - Enumerate all available local branches as branch ↔ C<SHA1> mappings.

=head1 VERSION

version 0.2.0

=head1 PARAMETERS

=head2 C<local_branches>

=head1 METHODS

=head2 C<local_branches>

Returns a map from C<git> of

    { branch_name => SHA1 }

=head1 COMPOSITION

Recommended application order if using this role:

    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";

=head1 REQUIRED METHODS

=head2 C<git>

Must be a Git::Wrapper instance.

Suggests L<Dist::Zilla::Role::Git::LocalRepository>

=head1 PRIVATE METHODS

=head2 _build_local_branches

Builder for L</local_branches>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::LocalRepository::LocalBranches",
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
