use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib/";

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
    _assert_valid_remote =>,
    _build__remotes      =>,
    _build_git           =>,
    _clear_remotes       =>,
    _has_remote          =>,
    _has_remotes         =>,
    _remote_name         =>,
    _remote_valid        =>,
    _remotes             =>,
    before_build         =>,
    clear_git            =>,
    do_update            =>,
    git                  =>,
    has_git              =>,
    remote               =>,
    remote_update        =>,
    packages_dzil_plugin(),
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);
done_testing;
