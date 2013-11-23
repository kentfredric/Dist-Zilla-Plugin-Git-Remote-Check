use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::CurrentBranch;

use Moose::Role;

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Role::Git::LocalRepository::CurrentBranch",
    "interface":"role",
    "does": [
        "Dist::Zilla::Role::Git::LocalRepository::LocalBranches"
    ]
}

=end MetaPOD::JSON

=cut

=requires C<git>

Must return a L<Git::Wrapper> or compatible instance

Available from

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository>

=back

=cut

=requires C<local_branches>

Must return a HashRef mapping branch name to branch sha1. 

Available from

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository::LocalBranches>

=back

=cut

requires 'local_branches';
requires 'git';

=p_method _current_sha1

Returns the SHA1 for the current HEAD

=cut

sub _current_sha1 {
  my $self = shift;
  return $self->git->rev_parse('HEAD');
}

=method C<current_branch>

If the consuming package is on a valid Git branch, this will return the name of it.

If not on a valid branch, will return false.

=cut

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
