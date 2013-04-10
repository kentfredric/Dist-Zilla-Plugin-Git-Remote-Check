use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::LocalRepository::LocalBranches;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";

  sub git { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::LocalRepository::LocalBranches',
  [
    _build_local_branches =>,
    clear_local_branches  =>,
    git                   =>,
    has_local_branches    =>,
    local_branches        =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
