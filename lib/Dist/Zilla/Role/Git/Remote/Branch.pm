use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Branch;

# FILENAME: RemoteBranch.pm
# CREATED: 12/10/11 16:46:21 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Parts to enable aggregated specification of remote branches.

use Moose::Role;

with 'Dist::Zilla::Role::Git::RemoteName';

=param C<remote_branch>

The name of the branch as it is on the remote side, in String form.

e.g: C<master>

=cut

has '_remote_branch' => (
  isa      => Str           =>,
  is       => ro            =>,
  default  => master        =>,
  init_arg => remote_branch =>,
);

=method C<remote_branch>

If used in conjunction with L<Dist::Zilla::Role::Git::RemoteName> to provide C<remote_name>,
then this method will expand the passed parameter C<remote_branch> in transit to a qualified one.

=cut

sub remote_branch {
  my $self = shift;
  return $self->remote_name . q{/} . $self->_remote_branch;
}

no Moose::Role;
1;

