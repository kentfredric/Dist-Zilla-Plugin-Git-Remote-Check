use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Plugin::Git::Remote::Check;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Check";

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap( 't::Plugin::Git::Remote::Check', [ packages_moose( { clean => 1, immutable => 1 } ) ] );

strict_nsmap(
  'Dist::Zilla::Plugin::Git::Remote::Check',
  [
    _build_remote_names   =>,
    _build_git            =>,
    _build_local_branches =>,
    _current_sha1         =>,
    _has_remote_name      =>,
    _incomming_commits    =>,
    _outgoing_commits     =>,
    _remote_branch        =>,
    _remote_name          =>,
    before_release        =>,
    branch                =>,
    check_remote          =>,
    clear_git             =>,
    clear_local_branches  =>,
    clear_remote_names    =>,
    current_branch        =>,
    do_update             =>,
    get_valid_remote_name =>,
    git                   =>,
    has_git               =>,
    has_remote_name       =>,
    has_remote_names      =>,
    has_local_branches    =>,
    is_current_branch     =>,
    local_branches        =>,
    remote_branch         =>,
    remote_name           =>,
    remote_names          =>,
    remote_update         =>,
    report_commits        =>,
    should_skip           =>,
    skip_if_not_current   =>,
    '$VERSION'            =>,
    packages_dzil_plugin(),
    packages_moose( { clean => 1, immutable => 1 } ),
    ( ($Dist::Zilla::Plugin::Git::Remote::Check::VERSION) ? (qw( $AUTHORITY $VERSION )) : () ),
  ]

);

done_testing;
