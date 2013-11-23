#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

my $recs;

sub add_rec {
  my ( $parent, @children ) = @_;
  $recs->{ 'Dist::Zilla::Role::' . $parent } = [ map { 'Dist::Zilla::Role::' . $_ } @children ];
}

sub get_deps {
  my ($parent) = @_;

  #my $role = 'Dist::Zilla::Role::' . $parent;
  my (@out);
  my (%seen);
  for my $child ( @{ $recs->{$parent} } ) {
    for my $new ( get_deps($child) ) {
      if ( not exists $seen{$new} ) {
        push @out, $new;
        $seen{$new} = 1;
      }
    }
  }
  push @out, $parent;
  return @out;
}

sub role_union {
  my (@roles) = @_;
  my (@out);
  my (%seen);
  for my $child (@roles) {
    for my $new ( get_deps($child) ) {
      if ( not exists $seen{$new} ) {
        push @out, $new;
        $seen{$new} = 1;
      }
    }
  }
  return @out;
}

add_rec( 'Git::LocalRepository'                => 'Plugin' );
add_rec( 'Git::LocalRepository::LocalBranches' => 'Git::LocalRepository' );
add_rec( 'Git::LocalRepository::CurrentBranch' => 'Git::LocalRepository', 'Git::LocalRepository::LocalBranches' );
add_rec( 'Git::RemoteName'                     => 'Plugin', 'Git::RemoteNames' );
add_rec( 'Git::RemoteNames'                    => 'Plugin', 'Git::LocalRepository' );
add_rec( 'Git::Remote::Check'                  => 'Plugin', 'Git::LocalRepository::CurrentBranch', 'Git::Remote::Branch' );
add_rec( 'Git::Remote::Branch'                 => 'Git::RemoteName' );
add_rec( 'Git::Remote::Update'                 => 'Plugin', 'Git::LocalRepository', 'Git::RemoteName' );

for my $parent ( sort keys %{$recs} ) {
  print "$parent : \n";
  for my $child ( get_deps($parent) ) {
    print "    with \"$child\";\n";
  }
  print "\n";
}

print "Dist::Zilla::Role::(Git::Remote::Check+Git::Remote::Update)\n";
for my $child ( role_union( "Dist::Zilla::Role::Git::Remote::Check", "Dist::Zilla::Role::Git::Remote::Update" ) ) {
  print "    with \"$child\";\n";
}
