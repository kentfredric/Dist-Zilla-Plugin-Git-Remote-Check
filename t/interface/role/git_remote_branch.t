use strict;
use warnings;

use Test::More;
{

  package t::Role::Git::Remote::Branch;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Git::Remote::Branch";

  sub log_fatal { }
  sub zilla     { }
  __PACKAGE__->meta->make_immutable;
}

pass("Compiled OK");
done_testing;
