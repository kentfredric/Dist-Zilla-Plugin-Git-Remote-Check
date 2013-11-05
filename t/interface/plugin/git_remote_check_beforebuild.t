use strict;
use warnings;

use Test::More;

{

  package t::Plugin::Git::Remote::Check::BeforeBuild;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Check::BeforeBuild";

  __PACKAGE__->meta->make_immutable;
}
pass("Compiled ok");
done_testing;
