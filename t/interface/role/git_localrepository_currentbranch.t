use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::LocalRepository::CurrentBranch;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::LocalRepository::CurrentBranch";

  sub git            { }
  sub local_branches { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::LocalRepository::CurrentBranch',
  [
    _current_sha1  =>,
    current_branch =>,
    git            =>,
    local_branches =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
