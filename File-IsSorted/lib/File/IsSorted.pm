package File::IsSorted;

use strict;
use warnings;

use Moo;

sub is_filehandle_sorted
{
    my ( $self, $args ) = @_;

    my $fh = $args->{fh};
    my $id = $args->{id} // 'unknown';

    my $prev = <$fh>;
    while ( my $l = <$fh> )
    {
        if ( $l le $prev )
        {
            die "<$l> less-or-equal than <$prev> in $id!";
        }
    }
    continue
    {
        $prev = $l;
    }

    return 1;
}

1;

__END__

=head1 NAME

File::IsSorted - check if the lines of a file are sorted lexicographically

=head2 $checker->is_filehandle_sorted({fh => $input_fh, id => "my-file.txt"});

Checks if $input_fh is sorted - throws an exception if it is not sorted and returns true
if it is.

=cut
