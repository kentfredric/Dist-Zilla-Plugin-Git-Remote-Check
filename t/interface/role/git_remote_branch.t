use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::Remote::Branch;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote::Branch";

  sub log_fatal { }
  sub zilla     { }
  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::Remote::Branch',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    _remote_branch        =>,
    _remote_name          =>,
    get_valid_remote_name =>,
    git                   =>,
    has_remote_name       =>,
    log_fatal             =>,
    remote_branch         =>,
    remote_name           =>,
    remote_names          =>,
    zilla                 =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
