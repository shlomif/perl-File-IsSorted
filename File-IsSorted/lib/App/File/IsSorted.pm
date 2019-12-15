package App::File::IsSorted;

use strict;
use warnings;
use 5.016;
use autodie;

use App::Cmd::Setup -app;

__END__

=head1 NAME

App::File::IsSorted - see L<is-sorted>

=head1 DESCRIPTION

Check if the lines of files are sorted.

=head1 SYNOPSIS

    is-sorted check .gitignore

=head1 METHODS

=head2 info

Implement the info subcommand.

=cut
