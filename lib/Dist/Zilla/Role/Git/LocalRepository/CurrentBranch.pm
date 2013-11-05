use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::CurrentBranch;

use Moose::Role;

with 'Dist::Zilla::Role::Git::LocalRepository::LocalBranches';

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
