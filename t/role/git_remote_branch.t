use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib/";

{

  package t::Role::Git::Remote::Branch;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote::Branch";

  sub git    { }
  sub remote { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::Remote::Branch',
  [
    git            =>,
    remote         =>,
    remote_branch  =>,
    _remote_branch =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
