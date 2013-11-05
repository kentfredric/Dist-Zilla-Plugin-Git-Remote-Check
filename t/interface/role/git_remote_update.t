use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::Remote::Update;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote::Update";

  sub log_fatal { }
  sub log       { }
  sub zilla     { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::Remote::Update',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    _remote_name          =>,
    do_update             =>,
    get_valid_remote_name =>,
    git                   =>,
    has_remote_name       =>,
    log                   =>,
    log_fatal             =>,
    remote_name           =>,
    remote_names          =>,
    remote_update         =>,
    zilla                 =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
