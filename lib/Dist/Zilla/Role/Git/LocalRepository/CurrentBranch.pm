use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::CurrentBranch;
BEGIN {
  $Dist::Zilla::Role::Git::LocalRepository::CurrentBranch::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::LocalRepository::CurrentBranch::VERSION = '0.2.0'; # TRIAL
}

# ABSTRACT: Query state from C<Git> about the current branch

use Moose::Role;



requires 'local_branches';
requires 'git';


sub _current_sha1 {
  my $self = shift;
  return $self->git->rev_parse('HEAD');
}


sub current_branch {
  my $self = shift;
  my $sha  = $self->_current_sha1;
  for my $name ( keys %{ $self->local_branches } ) {
    if ( $self->local_branches->{$name} eq $sha ) {
      return $name;
    }
  }
  return;
}

no Moose::Role;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::Git::LocalRepository::CurrentBranch - Query state from C<Git> about the current branch

=head1 VERSION

version 0.2.0

=head1 METHODS

=head2 C<current_branch>

If the consuming package is on a valid Git branch, this will return the name of it.

If not on a valid branch, will return false.

=head1 COMPOSITION

Recommended application order if using this role:

    with "Dist::Zilla::Role::Plugin";
    with "Dist::Zilla::Role::Git::LocalRepository";
    with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";
    with "Dist::Zilla::Role::Git::LocalRepository::CurrentBranch";

=head1 REQUIRED METHODS

=head2 C<git>

Must return a L<Git::Wrapper> or compatible instance

Suggests: L<Dist::Zilla::Role::Git::LocalRepository>

=head2 C<local_branches>

Must return a C<HashRef> mapping branch name to branch C<SHA1>.

Suggests: L<Dist::Zilla::Role::Git::LocalRepository::LocalBranches>

=head1 PRIVATE METHODS

=head2 C<_current_sha1>

Returns the C<SHA1> for the current C<HEAD>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::LocalRepository::CurrentBranch",
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
