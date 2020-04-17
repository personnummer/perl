#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;
use DateTime;
use Personnummer;

subtest 'Test age' => sub {
    my $now              = DateTime->now();
    my $twenty_tomorrow  = sprintf( "%04d%02d%02d-1111", $now->year - 20, $now->month, $now->day + 1, );
    my $twenty_yesterday = sprintf( "%04d%02d%02d-1111", $now->year - 20, $now->month, $now->day - 1, );
    my $one_hundred_one  = sprintf( "%04d%02d%02d-1111", $now->year - 101, 1, 1, );

    my @cases = (
        {
            input => $twenty_tomorrow,
            age   => 19,
        },
        {
            input => $twenty_yesterday,
            age   => 20,
        },
        {
            input => $one_hundred_one,
            age   => 101,
        },
    );

    foreach my $tc ( @cases ) {
        my $pnr = Personnummer->new( $tc->{input} );

        is( $pnr->get_age(), $tc->{age}, $tc->{input} . " correct age" );
    }
};

done_testing();
