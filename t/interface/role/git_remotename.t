use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::RemoteName;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::RemoteName";

  sub zilla     { }
  sub log_fatal { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::RemoteName',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    _remote_name          =>,
    clear_git             =>,
    clear_remote_names    =>,
    get_valid_remote_name =>,
    git                   =>,
    has_git               =>,
    has_remote_name       =>,
    has_remote_names      =>,
    log_fatal             =>,
    remote_name           =>,
    remote_names          =>,
    zilla                 =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
