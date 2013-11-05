use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::RemoteNames;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::RemoteNames";

  sub zilla     { }
  sub log_fatal { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::RemoteNames',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    get_valid_remote_name =>,
    git                   =>,
    has_remote_name       =>,
    log_fatal             =>,
    remote_names          =>,
    zilla                 =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
