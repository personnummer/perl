# perl-personnummer

Validate Swedish [personal identification
numbers](https://en.wikipedia.org/wiki/Personal_identity_number_(Sweden)) with
[Perl](https://www.perl.org/)


## Usage

Install with `cpanm` (or your preferred tool).

```perl
#!/usr/bin/env perl

user warnings;
use strict;

use Personnummer;

my $pnr = Personnummer->new( $ARGV[0] );

if ( !$pnr->valid() ) {
    die "Invalid personal identity number";
}

my $gender = $pnr->is_female() ? "female" : "male";

printf( "The person with personal identity number %s is a %s of age %d\n",
    $pnr->format(), $gender, $pnr->get_age() );
```
