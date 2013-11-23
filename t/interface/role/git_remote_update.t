use strict;
use warnings;

use Test::More;

{

  package t::Role::Git::Remote::Update;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::LocalRepository";
  with "Dist::Zilla::Role::Git::RemoteNames";
  with "Dist::Zilla::Role::Git::RemoteName";
  with "Dist::Zilla::Role::Git::Remote::Update";

  sub log_fatal { }
  sub log       { }
  sub zilla     { }
  sub log_debug { }

  __PACKAGE__->meta->make_immutable;
}

pass("Compiled OK");
done_testing;
