package App::File::IsSorted::Command::check;

use App::File::IsSorted -command;

use strict;
use warnings;
use autodie;
use 5.016;

use File::IsSorted ();

sub abstract { "check for files having sorted lines" }

sub description { return abstract(); }

sub opt_spec
{
    return ();
}

sub validate_args
{
    my ( $self, $opt, $args ) = @_;

    # no args allowed but options!
    $self->usage_error("args required") if not @$args;
}

sub execute
{
    my ( $self, $opt, $args ) = @_;

    my $checker = File::IsSorted->new;

    foreach my $path (@$args)
    {
        $checker->is_file_sorted( { path => $path } );
    }

    return;
}

1;
