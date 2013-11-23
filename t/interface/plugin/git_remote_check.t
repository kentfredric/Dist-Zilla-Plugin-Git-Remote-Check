use strict;
use warnings;

use Test::More;

{

  package t::Plugin::Git::Remote::Check;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Check";

  __PACKAGE__->meta->make_immutable;
}
pass("Compiled ok");
done_testing;
