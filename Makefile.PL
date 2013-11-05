
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Ensure no pending commits on a remote branch before release",
  "AUTHOR" => "Kent Fredric <kentnl\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Module::Build" => "0.4008"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.4008"
  },
  "DISTNAME" => "Dist-Zilla-Plugin-Git-Remote-Check",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::Plugin::Git::Remote::Check",
  "PREREQ_PM" => {
    "Data::Dump" => 0,
    "Dist::Zilla::Role::BeforeBuild" => 0,
    "Dist::Zilla::Role::BeforeRelease" => 0,
    "Dist::Zilla::Role::Plugin" => 0,
    "Git::Wrapper" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "1.001002"
  },
  "VERSION" => "0.1.3",
  "test" => {
    "TESTS" => "t/*.t t/interface/plugin/*.t t/interface/role/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Dump" => 0,
  "Dist::Zilla::Role::BeforeBuild" => 0,
  "Dist::Zilla::Role::BeforeRelease" => 0,
  "Dist::Zilla::Role::Plugin" => 0,
  "File::Spec" => 0,
  "Git::Wrapper" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.4008",
  "Moose" => 0,
  "Moose::Role" => 0,
  "Test::More" => "1.001002",
  "namespace::autoclean" => 0,
  "strict" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



