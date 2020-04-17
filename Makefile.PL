use strict;
use utf8;
use warnings;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
    NAME           => 'Personnummer',
    AUTHOR         => 'Simon Sawert <simon@sawert.se>',
    LICENSE        => 'MIT',
    ABSTRACT_FROM  => 'lib/Personnummer.pm',
    VERSION_FROM   => 'lib/Personnummer.pm',
    BUILD_REQUIRES => {},
    TEST_REQUIRES  => {},
    PREREQ_PM      => {
        'DateTime::Format::Strptime' => '>=1.76',
    },
    META_MERGE => {
        'dynamic_config' => 0,
        'meta-spec'      => { version => 2 },
        'resources'      => {
            bugtracker => { web => 'https://github.com/bombsimon/perl-personnummer/issues' },
            homepage   => 'https://github.com/bombsimon/perl-personnummer',
            repository => {
                type => 'git',
                url  => 'https://github.com/bombsimon/perl-personnummer.git',
                web  => 'https://github.com/bombsimon/perl-personnummer',
            },
        },
        'x_contributors' => ['Simon Sawert'],
    },
    test => {},
);

WriteMakefile( %WriteMakefileArgs );
