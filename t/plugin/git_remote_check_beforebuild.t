use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib/";

{

  package t::Plugin::Git::Remote::Check::BeforeBuild;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Check::BeforeBuild";

  __PACKAGE__->meta->make_immutable;
}

use tutil;
strict_nsmap(
  't::Plugin::Git::Remote::Check::BeforeBuild',
  [
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

strict_nsmap(
  'Dist::Zilla::Plugin::Git::Remote::Check::BeforeBuild',
  [
    _assert_valid_remote => , 
    _build__remotes => , 
    _build_git => , 
    _clear_remotes => ,
    _has_remote => , 
    _has_remotes => , 
    _incomming_commits => , 
    _outgoing_commits => ,
    _remote_branch => , 
    _remote_name => , 
    _remote_valid => , 
    _remotes => , 
    before_release => , 
    branch => , 
    check_remote => , 
    clear_git => , 
    do_update => 
    git => , 
    has_git => , 
    is_current_branch => , 
    remote => ,
    remote_branch => , 
    remote_update => , 
    report_commits => , 
    should_skip => , 
    skip_if_not_current => ,
    packages_dzil_plugin(),
    packages_moose( { clean => 1, immutable => 1 } ),
    (( $Dist::Zilla::Plugin::Git::Remote::Check::BeforeBuild::VERSION ) ? (qw(  $AUTHORITY $VERSION )) : ()),
  ]

);




done_testing;
