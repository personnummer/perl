#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;

require_ok( 'Personnummer' );

subtest 'Init and parse' => sub {
    my $pnr = Personnummer->new( "19880401-8573" );
    is( $pnr->{date}->ymd, "1988-04-01", "date parsed OK" );

    $pnr = Personnummer::parse( "19900101-0017" );
    is( $pnr->{date}->ymd, "1990-01-01", "date and object parsed OK from parse" );
};

subtest 'Formatting' => sub {
    my @cases = (
        {
            input => "19900101-0017",
            short => "900101-0017",
            long  => "19900101-0017"
        },
        {
            input => "900101-0017",
            short => "900101-0017",
            long  => "19900101-0017"
        },
        {
            input => "9001010017",
            short => "900101-0017",
            long  => "19900101-0017"
        },
        {
            input => "19900101+0017",
            short => "900101-0017",
            long  => "19900101-0017"
        },
        {
            input => "900101+0017",
            short => "900101-0017",
            long  => "19900101-0017"
        },
        {
            input => "900161-0017",
            short => "900161-0017",
            long  => "19900161-0017"
        },
    );

    foreach my $tc ( @cases ) {
        my $pnr = Personnummer->new( $tc->{input} );

        is( $pnr->format(),    $tc->{short}, $tc->{input} . " implicit short format" );
        is( $pnr->format( 0 ), $tc->{short}, $tc->{input} . " explicist short format" );
        is( $pnr->format( 1 ), $tc->{long},  $tc->{input} . " long format" );
    }
};

done_testing();
