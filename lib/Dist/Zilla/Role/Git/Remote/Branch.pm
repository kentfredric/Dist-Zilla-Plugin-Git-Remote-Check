use strict;
use warnings;

package Dist::Zilla::Role::Git::Remote::Branch;

# FILENAME: RemoteBranch.pm
# CREATED: 12/10/11 16:46:21 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Parts to enable aggregated specification of remote branches.

use Moose::Role;

=requires C<git>

Must return a L<Git::Wrapper> or compatible instance.

Available from:

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository>

=back

=cut

requires 'git';

=requires C<remote>

Must return a String value representing a remote name ( as displayed in C<git remote> ).

Available from:

=over 4

=item * L<Dist::Zilla::Role::Git::Remote>

=back

=cut

requires 'remote';

=param C<remote_branch>

The name of the branch as it is on the remote side, in String form.

e.g: C<master>

=cut

has '_remote_branch' => (
  isa      => 'Str',
  is       => 'rw',
  default  => 'master',
  init_arg => 'remote_branch',
);

=method C<remote_branch>

If used in conjunction with L<Dist::Zilla::Role::Git::Remote> to provide C<remote>,
then this method will expand the passed parameter C<remote_branch> in transit to a qualified one.

=cut

sub remote_branch {
  my $self = shift;
  return $self->remote . q{/} . $self->_remote_branch;
}

no Moose::Role;
1;

