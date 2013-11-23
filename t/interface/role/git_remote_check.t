use strict;
use warnings;

use Test::More;

{

  package t::Role::Git::Remote::Check;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::LocalRepository";
  with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";
  with "Dist::Zilla::Role::Git::LocalRepository::CurrentBranch";
  with "Dist::Zilla::Role::Git::RemoteNames";
  with "Dist::Zilla::Role::Git::RemoteName";
  with "Dist::Zilla::Role::Git::Remote::Branch";
  with "Dist::Zilla::Role::Git::Remote::Check";

  sub log { }
  sub log_fatal { }
  sub zilla     { }
  sub branch    { }

  __PACKAGE__->meta->make_immutable;
}

pass('Compiled Ok');
done_testing;
