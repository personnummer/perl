#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;
use DateTime;
use Personnummer;

subtest 'Test age' => sub {
    my $tt = DateTime->now()->add( years => -20 )->add( months => 1 );
    my $ty = DateTime->now()->add( years => -20 )->add( days   => -1 );
    my $h  = DateTime->now()->add( years => -101 );

    my $twenty_tomorrow  = sprintf( "%04d%02d%02d-1111", $tt->year, $tt->month, $tt->day );
    my $twenty_yesterday = sprintf( "%04d%02d%02d-1111", $ty->year, $ty->month, $ty->day );
    my $one_hundred_one  = sprintf( "%04d%02d%02d-1111", $h->year,  1,          1, );

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

        is( $pnr->get_age(), $tc->{age}, $tc->{input} . " correct age " . $tc->{age} );
    }
};

done_testing();
