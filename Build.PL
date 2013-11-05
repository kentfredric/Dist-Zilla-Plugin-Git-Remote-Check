
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.4008"
  },
  "configure_requires" => {
    "Module::Build" => "0.4008"
  },
  "dist_abstract" => "Ensure no pending commits on a remote branch before release",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-Plugin-Git-Remote-Check",
  "dist_version" => "0.1.3",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Plugin::Git::Remote::Check",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Data::Dump" => 0,
    "Dist::Zilla::Role::BeforeBuild" => 0,
    "Dist::Zilla::Role::BeforeRelease" => 0,
    "Dist::Zilla::Role::Git::Remote" => 0,
    "Dist::Zilla::Role::Plugin" => 0,
    "Git::Wrapper" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "namespace::autoclean" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "Dist::Zilla" => 0,
    "Dist::Zilla::Tester" => 0,
    "File::Spec" => 0,
    "FindBin" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Package::Stash" => 0,
    "Sub::Exporter" => 0,
    "Test::More" => "1.001002",
    "lib" => 0
  }
);


my %fallback_build_requires = (
  "Dist::Zilla" => 0,
  "Dist::Zilla::Tester" => 0,
  "File::Spec" => 0,
  "FindBin" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.4008",
  "Package::Stash" => 0,
  "Sub::Exporter" => 0,
  "Test::More" => "1.001002",
  "lib" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
