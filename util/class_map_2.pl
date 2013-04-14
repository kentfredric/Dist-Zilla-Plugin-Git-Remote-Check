#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use lib '/home/kent/perl/Introspect/lib';
use Introspect;

use Data::Dump qw( pp );

my (@classes) = (
  'Dist::Zilla::Plugin::Git::Remote::Check',  'Dist::Zilla::Plugin::Git::Remote::Check::BeforeBuild',
  'Dist::Zilla::Plugin::Git::Remote::Update', 'Dist::Zilla::Plugin::Git::Remote::Update::BeforeBuild',
  'Dist::Zilla::Role::Git::LocalRepository',  'Dist::Zilla::Role::Git::Remote::Branch',
  'Dist::Zilla::Role::Git::Remote::Update',
);

my $classx = {};

for my $class (@classes) {
  if ( not exists $classx->{$class} ) {
    $classx->{$class} = 0;
  }
}

sub _has_todo {
  grep { exists $classx->{$_} and $classx->{$_} == 0 } keys $classx;
}

sub _add_todo {
  local $_ = $_[0];
  return if exists $classx->{$_};
  return if $_ eq 'Moo::Object';
  $classx->{$_} = 0;
}


while ( my @todo = _has_todo ) {
  for my $class (@todo) {
    for my $inherit ( @{ Introspect->for_class($class)->inherits } ) {
      _add_todo($inherit);
    }
    for my $compose ( @{ Introspect->for_class($class)->composes } ) {
      _add_todo($compose);
    }
#    print pp( Introspect->for_class($class)->as_hash );
    $classx->{$class} = Introspect->for_class($class)->as_hash;
  }
}

sub print_data {
    print "=begin data\n\n";
    print pp($_[0]);
    print "\n\n=end data\n\n";
    
}
sub print_visibility_hash
{
    my ( $heading, $data ) = @_;
    print "=head2 $heading\n\n";
    #   print_data($data);
    for my $visibility (qw( public private )){ 

        for my $inference  (qw( own inherited )) {
                if( $data->{$inference}->{ $visibility } ) {
                    print "=head3 $inference $visibility\n\n";
                    for my $param ( keys %{ $data->{$inference}->{ $visibility } } ) { 
                        print "=head4 $param\n\n";
                    }
                }
            }
        }

}
sub print_visibility_list
{
    my ( $heading, $data ) = @_;
    print "=head2 $heading\n\n";
#    print_data($data);
    for my $visibility (qw( public private )){ 

        for my $inference  (qw( own inherited )) {
                if( $data->{$inference}->{ $visibility } ) {
                    print "=head3 $inference $visibility\n\n";
                    for my $param ( @{ $data->{$inference}->{ $visibility } } ) { 
                        print "=head4 $param\n\n";
                    }
                }
            }
        }

}

for my $pkg ( sort keys %$classx ) {
    my $d = $classx->{$pkg};
    print "=head1 $pkg\n\n";

    print_visibility_hash('Constructor Arguments', $d->{constructorargs_as_hash}) if $d->{constructorargs_as_hash} ;
    print_visibility_hash('Attributes', $d->{attributes_as_hash}) if $d->{attributes_as_hash};
    print_visibility_hash('Attribute Accessors', $d->{accessors_as_hash}) if $d->{accessors_as_hash};
    print_visibility_list('Methods' , $d->{methods_as_hash} ) if  $d->{methods_as_hash} ;

}

__END__

my $instance = Introspect->for_class('Dist::Zilla::Plugin::Git::Remote::Update');

pp( $instance->accessors->as_hash );

