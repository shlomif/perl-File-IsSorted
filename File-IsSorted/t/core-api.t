#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use Test::More tests => 2;

use Path::Tiny qw/ path tempdir tempfile cwd /;

use File::IsSorted ();

my $dir = tempdir();

my $GOOD_TEXT = <<'EOF';
a
b
d
j
u
EOF

{
    open my $fh, '<', \$GOOD_TEXT;
    my $sorter = File::IsSorted->new;

    # TEST
    ok( scalar( $sorter->is_filehandle_sorted( { fh => $fh } ) ),
        "simple fh test" );
}

{
    my $fh = $dir->child('good.txt');
    $fh->spew_raw($GOOD_TEXT);

    my $sorter = File::IsSorted->new;

    # TEST
    ok( scalar( $sorter->is_file_sorted( { path => "$fh", } ) ),
        "simple path test" );
}
