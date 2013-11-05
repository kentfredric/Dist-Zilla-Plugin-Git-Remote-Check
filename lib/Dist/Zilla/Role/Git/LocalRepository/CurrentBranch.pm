use strict;
use warnings;

package Dist::Zilla::Role::Git::LocalRepository::CurrentBranch;
BEGIN {
  $Dist::Zilla::Role::Git::LocalRepository::CurrentBranch::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Role::Git::LocalRepository::CurrentBranch::VERSION = '0.1.3';
}

use Moose::Role;



requires 'git';


requires 'local_branches';


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

=head1 NAME

Dist::Zilla::Role::Git::LocalRepository::CurrentBranch

=head1 VERSION

version 0.1.3

=head1 METHODS

=head2 C<current_branch>

If the consuming package is on a valid Git branch, this will return the name of it.

If not on a valid branch, will return false.

=head1 REQUIRED METHODS

=head2 C<git>

Must return a L<Git::Wrapper> or compatible instance

Available from

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository>

=back

=head2 C<local_branches>

Must return a HashRef mapping branch name to branch sha1. 

Available from

=over 4

=item * L<Dist::Zilla::Role::Git::LocalRepository::LocalBranches>

=back

=head1 PRIVATE METHODS

=head2 _current_sha1

Returns the SHA1 for the current HEAD

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
