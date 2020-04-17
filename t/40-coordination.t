#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;
use Personnummer;

subtest 'Test coordination number' => sub {
    my %cases = (
        "800161-3294" => 1,
        "800101-3294" => 0,
        "640327-3813" => 0,
    );

    while ( my ( $tc, $is_coordination_number ) = each %cases ) {
        my $pnr = Personnummer->new( $tc );

        is( $pnr->is_coordination_number(),
            $is_coordination_number, "$tc classed as coordinational number correctly" );
    }
};

done_testing();
