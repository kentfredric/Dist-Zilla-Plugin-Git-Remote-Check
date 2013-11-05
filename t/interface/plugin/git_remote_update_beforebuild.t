use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Plugin::Git::Remote::Update::BeforeBuild;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Update::BeforeBuild";

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap( 't::Plugin::Git::Remote::Update::BeforeBuild', [ packages_moose( { clean => 1, immutable => 1 } ) ] );
strict_nsmap(
  'Dist::Zilla::Plugin::Git::Remote::Update::BeforeBuild',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    _remote_name          =>,
    before_build          =>,
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
