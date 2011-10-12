use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Branch;

# FILENAME: RemoteBranch.pm
# CREATED: 12/10/11 16:46:21 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Parts to enable aggregated specification of remote branches.

use Moose::Role;

requires 'git';
requires 'remote';

has '_remote_branch' => (
  isa      => 'Str',
  is       => 'rw',
  default  => 'master',
  init_arg => 'remote_branch',
);

=method remote_branch

If used in conjuction with L<Dist::Zilla::Role::Git::Remote> to provide C<remote>,
then this method will expand the passed paramter C<remote_branch> in transit to a qualified one.

=cut

sub remote_branch {
  my $self = shift;
  return $self->remote . '/' . $self->_remote_branch;
}

no Moose::Role;
1;

