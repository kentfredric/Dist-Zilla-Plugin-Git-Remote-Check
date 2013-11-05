use strict;
use warnings;

use Test::More;

{

  package t::Role::Git::RemoteName;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::RemoteName";

  sub zilla     { }
  sub log_fatal { }

  __PACKAGE__->meta->make_immutable;
}

pass("Compiled OK");
done_testing;
