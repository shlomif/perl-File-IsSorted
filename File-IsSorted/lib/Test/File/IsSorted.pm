package Test::File::IsSorted;

use strict;
use warnings;

use parent 'Test::Builder::Module';

use List::Util qw/ all /;
use File::IsSorted ();

my $CLASS = __PACKAGE__;

sub are_sorted
{
    my ( $paths, $name ) = @_;

    my $tb = $CLASS->builder;

    my $checker = File::IsSorted->new;
    return $tb->ok(
        scalar(
            all { $checker->is_file_sorted( +{ path => $_ } ); }
            @$paths
        ),
        $name
    );
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

=head1 FUNCTIONS

=head2 are_sorted([@paths], $blurb);

Checks if all of the filesystem paths are sorted.

=cut
