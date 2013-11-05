use strict;
use warnings;

use Sub::Exporter -setup => {
  exports => [
    strict_nsmap         =>,
    packages_moose       =>,
    packages_dzil_plugin =>,
  ],
  groups => { default => [':all'], },
};
use Data::Dump qw( pp );

sub _moose_clean {
  return (
    #  BEGIN =>,
    '@ISA' =>,

    #  isa   =>,
    meta =>,
  );
}

sub _moose_immutable {
  return (
    DESTROY =>,

    # can     =>,
    new =>,
  );
}

sub _moose_exports {
  return (
    after    =>,
    around   =>,
    augment  =>,
    before   =>,
    blessed  =>,
    confess  =>,
    extends  =>,
    has      =>,
    inner    =>,
    override =>,
    super    =>,
    with     =>,
  );
}

sub packages_moose {
  my ($conf) = shift;
  my (@out)  = _moose_clean;

  push @out, _moose_exports unless ( exists $conf->{clean} and $conf->{clean} );

  push @out, _moose_immutable if ( exists $conf->{immutable} and $conf->{immutable} );
  return @out;
}

sub packages_dzil_plugin {
  return (
    plugin_name         =>,
    zilla               =>,
    logger              =>,
    log                 =>,
    log_debug           =>,
    log_fatal           =>,
    mvp_multivalue_args =>,
    mvp_aliases         =>,
    plugin_from_config  =>,
    register_component  =>,
    dump_config         =>,
  );
}

sub strict_nsmap {
  my ( $package, $expected ) = @_;
  require Package::Stash;
  require Test::More;

  my $stash   = Package::Stash->new($package);
  my $symbols = {};

  for my $sym ( $stash->list_all_symbols('CODE') ) {
    $symbols->{$sym} = 'CODE';
  }
  for my $sym ( $stash->list_all_symbols('SCALAR') ) {
    $symbols->{ '$' . $sym } = 'SCALAR';
  }
  for my $sym ( $stash->list_all_symbols('HASH') ) {
    $symbols->{ '%' . $sym } = 'HASH';
  }
  for my $sym ( $stash->list_all_symbols('ARRAY') ) {
    $symbols->{ '@' . $sym } = 'ARRAY';
  }

  my $pass = 1;

  for my $expected_symbol ( @{$expected} ) {
    if ( exists $symbols->{$expected_symbol} ) {
      delete $symbols->{$expected_symbol};
      Test::More::pass("$package has symbol $expected_symbol");
      next;
    }
    Test::More::fail("$package has symbol $expected_symbol");
    undef $pass;
  }
  for my $ignore (qw( $VERSION $AUTHORITY )) {
    delete $symbols->{$ignore} if exists $symbols->{$ignore};
  }
  if ( keys %{$symbols} ) {
    Test::More::fail("$package doesn't have unexpected symbols");
    Test::More::diag( "Unexpected symbols: $package [" . ( join ", ", keys %{$symbols} ) . "]" );
    for my $key ( sort keys %{$symbols} ) {
      Test::More::diag( " $key => " . $symbols->{$key} );
    }
    undef $pass;
  }
  else {
    Test::More::pass("$package doesn't have unexpected symbols");
  }
  return $pass;
}

1;
