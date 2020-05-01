#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;
use Personnummer;

subtest 'Valid personal identity numbers' => sub {
    my @cases = (
        "20160229-1237", "6403273813", "19900101-0017", "196408233234", "000101-0107", "510818-9167",
        "19130401+2931", "0001010107", "19090903-6600",
    );

    foreach my $tc ( @cases ) {
        my $pnr = Personnummer->new( $tc );

        ok( $pnr->valid(), sprintf( "pnr %s is valid", $pnr->format() ) );
    }
};

subtest 'Invalid personal identity numbers' => sub {
    my @cases = ( "201702291236", "6403273814", "510819-9167", "640327-381", "640327-3814", );

    foreach my $tc ( @cases ) {
        my $pnr = Personnummer->new( $tc );

        ok( !$pnr->valid(), sprintf( "pnr %s is invalid", $tc ) );
    }
};

done_testing();
