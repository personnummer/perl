package Personnummer;

use warnings;
use strict;

our $VERSION = '0.01';

1;

=head1 NAME

Personnummer - Validate Swedish social security numbers

=head1 SYNOPSIS

    use Personnummer;

    die 'Invalid social security number'
        if !Personnummer->new('19900101-1234')->valid();

=head1 DESCRIPTION

L<Personnummer> validates and extracts information about Swedish social security
numbers. It's implemented to follow the design described in
L<https://github.com/personnummer/meta>.

=head1 AUTHOR

Simon Sawert - L<simon@sawert.se>

=cut
