#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use Test::More tests => 1;

use File::IsSorted ();

{
    my $GOOD_TEXT = <<'EOF';
a
b
d
j
u
EOF
    open my $fh, '<', \$GOOD_TEXT;
    my $sorter = File::IsSorted->new;

    # TEST
    ok( scalar( $sorter->is_filehandle_sorted( { fh => $fh } ) ),
        "simple fh test" );
}
