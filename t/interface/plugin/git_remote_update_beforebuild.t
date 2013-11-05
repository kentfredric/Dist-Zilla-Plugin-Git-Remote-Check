use strict;
use warnings;

use Test::More;

{

  package t::Plugin::Git::Remote::Update::BeforeBuild;
  use Moose;
  use namespace::autoclean;
  extends "Dist::Zilla::Plugin::Git::Remote::Update::BeforeBuild";

  __PACKAGE__->meta->make_immutable;
}

pass("Compiled OK");
done_testing;
