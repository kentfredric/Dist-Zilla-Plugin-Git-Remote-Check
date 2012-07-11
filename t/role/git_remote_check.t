use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib/";

{

  package t::Role::Git::Remote::Check;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote::Check";

  sub git           { }
  sub remote_branch { }
  sub branch        { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::Remote::Check',
  [
    _incomming_commits  =>,
    _outgoing_commits   =>,
    branch              =>,
    check_remote        =>,
    git                 =>,
    is_current_branch   =>,
    remote_branch       =>,
    report_commits      =>,
    should_skip         =>,
    skip_if_not_current =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
