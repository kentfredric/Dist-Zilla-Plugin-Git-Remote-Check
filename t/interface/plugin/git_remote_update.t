use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Plugin::Git::Remote::Update;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Update";

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap( 't::Plugin::Git::Remote::Update', [ packages_moose( { clean => 1, immutable => 1 } ) ] );
strict_nsmap(
  'Dist::Zilla::Plugin::Git::Remote::Update',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    _remote_name          =>,
    before_release        =>,
    do_update             =>,
    get_valid_remote_name =>,
    git                   =>,
    has_remote_name       =>,
    remote_name           =>,
    remote_names          =>,
    remote_update         =>,
    packages_dzil_plugin(),
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);
done_testing;
