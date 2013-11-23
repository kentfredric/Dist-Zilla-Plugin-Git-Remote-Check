use strict;
use warnings;

use Test::More;

{

  package t::Role::Git::LocalRepository::CurrentBranch;
  use Moose;
  use namespace::autoclean;
  with "Dist::Zilla::Role::Plugin";
  with "Dist::Zilla::Role::Git::LocalRepository";
  with "Dist::Zilla::Role::Git::LocalRepository::LocalBranches";
  with "Dist::Zilla::Role::Git::LocalRepository::CurrentBranch";


  sub zilla { }

  __PACKAGE__->meta->make_immutable;
}

pass('compiled ok');
done_testing;
