#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;
use Personnummer;

subtest 'Test genders' => sub {
    my %genders = (
        "800101-3294"   => 0,
        "000903-6603"   => 1,
        "19090903-0023" => 1,
        "800101+3294"   => 0,
    );

    while ( my ( $tc, $is_female ) = each %genders ) {
        my $pnr = Personnummer->new( $tc );

        is( $pnr->is_female(), $is_female,     "$tc classed as female correctly" );
        is( $pnr->is_male(),   $is_female ^ 1, "$tc classed as male correctly" );
    }
};

done_testing();
