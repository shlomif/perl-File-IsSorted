package File::IsSorted;

use strict;
use warnings;
use autodie;
use 5.016;
no locale;

use Moo;

use Path::Tiny qw/ path /;

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

sub is_file_sorted
{
    my ( $self, $args ) = @_;

    my $path = $args->{path};
    my $id   = $args->{id} // $path;

    return $self->is_filehandle_sorted(
        { fh => path($path)->openr, id => $id } );
}

1;

__END__

=head1 NAME

File::IsSorted - check if the lines of a file are sorted lexicographically

=head1 SYNOPSIS

    use File::IsSorted ();

    my $checker = File::IsSorted->new;

    $checker->is_file_sorted({ path => ".gitignore" });

=head1 DESCRIPTION

This checks if the lines of files or filehandles are monotonically and lexicographically
increasing, (= are already sorted). It may consume less RAM and be faster than the
naive way of doing C<< cmp myfile.txt <(LC_ALL=C sort myfile.txt) >> and it runs at
O(n) instead of O(n*log(n)) time and keeps O(1) lines instead of O(n).

=head1 METHODS

=head2 my $checker = File::IsSorted->new

Constructs a new object.

=head2 $checker->is_filehandle_sorted({fh => $input_fh, id => "my-file.txt"});
Checks if $input_fh is sorted - throws an exception if it is not sorted and returns true
if it is.

=head2 $checker->is_file_sorted({path => "/path/to/file.txt", id => "my-file.txt"});

Checks if the file at path is sorted - throws an exception if it is not sorted
and returns true if it is.

=cut
