use strict;
use warnings;

use Test::More;

{

  package t::Role::Git::LocalRepository::LocalBranches;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";

  sub git   { }
  sub zilla { }

  __PACKAGE__->meta->make_immutable;
}
pass("Compiled OK");
done_testing;
