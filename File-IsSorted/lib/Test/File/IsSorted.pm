package Test::File::IsSorted;

use strict;
use warnings;

use parent 'Test::Builder::Module';

use List::Util 1.34 qw/ all /;
use File::IsSorted ();

my $CLASS = __PACKAGE__;

sub are_sorted
{
    my ( $paths, $name ) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    no locale;
    return are_sorted2( [ sort @$paths ], $name );
}

sub are_sorted2
{
    my ( $paths, $name ) = @_;

    #    local $Test::Builder::Level = $Test::Builder::Level + 1;

    no locale;
    my $paths_text = join "\n", @$paths, "";
    my $tb = $CLASS->builder;

    my $checker = File::IsSorted->new;
    open my $fh, '<', \$paths_text;
    scalar( $checker->is_filehandle_sorted( { fh => $fh, } ) );
    close($fh);

    # $tb->plan(2);
    my $ok = $tb->ok(
        scalar( all { $checker->is_file_sorted( +{ path => $_ } ); } @$paths ),
        $name
    );

    return !$ok;
}

1;

__END__

=head1 NAME

Test::File::IsSorted - test files for being lexicographical sorted.

=head1 SYNOPSIS

    use Test::More tests => 1;

    use Test::File::IsSorted ();

    # TEST
    Test::File::IsSorted::are_sorted([".gitignore", "MANIFEST.SKIP"],
        "Files are sorted");

=head1 DESCRIPTION

This checks if the lines of files or filehandles are monotonically and lexicographically
increasing, (= are already sorted). It may consume less RAM and be faster than the
naive way of doing C<< cmp myfile.txt <(LC_ALL=C sort myfile.txt) >> and it runs at
O(n) instead of O(n*log(n)) time and keeps O(1) lines instead of O(n).

=head1 FUNCTIONS

=head2 are_sorted([@paths], $blurb);

Checks if all of the filesystem paths are sorted.

=head2 are_sorted2([@paths], $blurb);

Checks if all of the filesystem paths are sorted. Also checks that @paths are sorted.

Added in version v0.2.0.

=cut
