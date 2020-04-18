package Personnummer;

use warnings;
use strict;
use feature qw( say );

use Carp;
use DateTime;

our $VERSION = '0.01';

sub new {
    my ( $class, $pnr ) = @_;

    my $args = {
        original => $pnr,
        _parse( $pnr ),
    };

    return bless $args, $class;
}

sub parse {
    my $pnr = shift;

    return __PACKAGE__->new( $pnr );
}

sub format {
    my $self        = shift;
    my $long_format = shift // 0;

    croak "cannot format invalid social security numbers" if not $self->valid();

    my $year = $long_format ? $self->{date}->year : $self->{date}->year % 100;
    my $day = $self->{is_coordination_number} ? $self->{date}->day + 60 : $self->{date}->day;

    return
      sprintf( "%s%02d%02d-%03d%d", $year, $self->{date}->month, $day, $self->{serial}, $self->{control} );
}

sub get_age {
    my $self = shift;

    croak "cannot get age of invalid social security number" if not defined $self->{date};

    my $diff = DateTime->now() - $self->{date};

    return $diff->years();
}

sub valid {
    my $self = shift;

    return if not defined $self->{date};

    my $pnr = sprintf(
        "%02d%02d%02d%03d",
        $self->{date}->year % 100,
        $self->{date}->month,
        $self->{date}->day,
        $self->{serial}
    );

    return defined $self->{date} && _luhn( $pnr ) == ( $self->{control} // -1 );
}

sub is_female {
    my $self = shift;

    return ( ( $self->{serial} % 10 ) % 2 ) == 0 ? 1 : 0;
}

sub is_male {
    my $self = shift;

    return $self->is_female() ? 0 : 1;
}

sub is_coordination_number {
    return shift->{is_coordination_number};
}

sub _luhn {
    my $number = shift;

    my $sum  = 0;
    my $even = 1;

    foreach my $digit ( split //, $number ) {
        if ( $even ) {
            if ( ( $digit *= 2 ) > 9 ) {
                $digit -= 9;
            }
        }

        if ( ( $sum += $digit ) > 9 ) {
            $sum -= 10;
        }

        $even ^= 1;
    }

    my $checksum = 10 - ( $sum % 10 );

    return $checksum == 10 ? 0 : $checksum;
}

sub _parse {
    my $pnr = shift;

    my ( $century, $year, $month, $day, $divider, $serial, $control )
      = $pnr =~ /^(\d{2})?(\d{2})(\d{2})(\d{2})([-|+]?)?(\d{3})(\d)?$/x;

    return () if not defined $year;

    $century = defined $century ? $century * 100 : 1900;

    my $date;

    eval {
        $date = DateTime->new(
            year   => $century + $year,
            month  => $month,
            day    => $day % 60,
            hour   => 0,
            minute => 0,
            second => 0,
        );
    };

    if ( my $error = $@ ) {
        if ( $error =~ /Invalid day of month/ ) {
            return ();
        }

        croak "unknown error parsing date: " . $error;
    }

    return (
        date                   => $date,
        serial                 => $serial,
        control                => $control,
        divider                => $divider,
        is_coordination_number => $day > 31 ? 1 : 0,
    );
}

1;

=head1 NAME

Personnummer - Validate Swedish social security numbers

=head1 SYNOPSIS

    use Personnummer;

    die "Invalid social security number"
        if not Personnummer->new("19900101-1234")->valid();

=head1 DESCRIPTION

L<Personnummer> validates and extracts information about Swedish social security
numbers. It's implemented to follow the design described in
L<https://github.com/personnummer/meta>.

=head1 METHODS

=head2 new

Create a new instance of a Personnummer object. Accepted formats:

=over

=item YYMMDD-XXXX

=item YYYYMMDD-XXXX

=item YYMMDD+XXXX

=item YYYYMMDD+XXXX

=item YYMMDDXXXX

=item YYYYMMDDXXXX

=back

    my $pnr = Personnummer->new("19900101-0101");

=head2 parse

Same as new but is called without the class instance.

    my $pnr = Personnummer::parse("19900101-0101");

=head2 format

Format the social security number. Takes an optional argument which will print
in long format (full year) if passed as a true value.

=head2 get_age

Get the age for a given social security number. Will crash if the object
instance isn't valid.

=head2 valid

Will validate the social security number by checking if the date is valid and if
the last digits matches the result of the Luhn algorithm.

=head2 is_female

Returns 1 if the social security number represents a female, otherwize 0.

=head2 is_male

Returns 1 if the social security number represents a male, otherwize 0.

=head2 is_coordination_number

Returns 1 if the personal number is a coordinational number, otheriwze 0.

=cut

=head1 AUTHOR

Simon Sawert - L<simon@sawert.se>

=cut
