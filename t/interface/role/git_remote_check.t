use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib/";

{

  package t::Role::Git::Remote::Check;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote::Check";

  sub log_fatal { }
  sub zilla     { }
  sub branch    { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::Remote::Check',
  [
    _build_git            =>,
    _build_remote_names   =>,
    _has_remote_name      =>,
    _incomming_commits    =>,
    _outgoing_commits     =>,
    _remote_branch        =>,
    _remote_name          =>,
    branch                =>,
    check_remote          =>,
    get_valid_remote_name =>,
    git                   =>,
    has_remote_name       =>,
    is_current_branch     =>,
    log_fatal             =>,
    remote_branch         =>,
    remote_name           =>,
    remote_names          =>,
    report_commits        =>,
    should_skip           =>,
    skip_if_not_current   =>,
    zilla                 =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
