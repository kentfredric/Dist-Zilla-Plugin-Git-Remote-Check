use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib/";

{

  package t::Role::Git::Remote;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote";

  sub git       { }
  sub log_fatal { }

  __PACKAGE__->meta->make_immutable;
}

use tutil;

strict_nsmap(
  't::Role::Git::Remote',
  [
    _assert_valid_remote =>,
    _build__remotes      =>,
    _clear_remotes       =>,
    _has_remote          =>,
    _has_remotes         =>,
    _remote_name         =>,
    _remote_valid        =>,
    _remotes             =>,
    git                  =>,
    log_fatal            =>,
    remote               =>,
    packages_moose( { clean => 1, immutable => 1 } )
  ]
);

done_testing;
