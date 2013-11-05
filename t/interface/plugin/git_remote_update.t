use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib/";

{

  package t::Plugin::Git::Remote::Update;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Update";

  __PACKAGE__->meta->make_immutable;
}
{

  package FZil;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla";
  has '+chrome' => ( required => 0 );
  __PACKAGE__->meta->make_immutable;

}
use tutil;

strict_nsmap( 't::Plugin::Git::Remote::Update', [ packages_moose( { clean => 1, immutable => 1 } ) ] );
strict_nsmap(
  'Dist::Zilla::Plugin::Git::Remote::Update',
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
    before_release       =>,
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

# Real tests begin
require Dist::Zilla::Tester;

my $zilla = Dist::Zilla::Tester::_Builder->from_config();

my $instance = t::Plugin::Git::Remote::Update->new(
  plugin_name => 'Update_test',
  zilla       => $zilla,

);
$instance->before_release();

diag explain $instance;
done_testing;
