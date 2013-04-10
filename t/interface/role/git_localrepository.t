use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::LocalRepository;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::LocalRepository";

  sub zilla { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::LocalRepository',
  [
    _build_git =>,
    clear_git  =>,
    git        =>,
    has_git    =>,
    zilla      =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
