#!/usr/bin/perl

use strict;
use warnings;
use 5.10.0; # given/when

package Arbiter::Dir;

=pod

=head1 DESCRIPTION

Directory <=> data value conversion

=head1 USAGE

Arbiter::Dir::writedata($path, $data)
Arbiter::Dir::readdata($path) => $data

=head1 DETAILS

=cut

sub writedata {
    my ($path, $v) = @_;

    # XXX: do I want to support this?
    if (!defined $v) {
        writefile($path, "");
        return;
    }

    given (ref($v)) {
        when ([undef, ""]) { writefile($path, $v)  }
        when ("SCALAR")    { writedata($path, $$v) } # XXX: do I want to support this?
        when ("HASH")      { writehash($path, $v)  }
        when ("ARRAY")     { writelist($path, $v)  }
        default            { die "Unsupported data type " . ref($v) . " for key $path\n" }
    }
}

sub writehash {
    my ($path, $state) = @_;

    mkdir $path; # or die "Error creating $path: $!";

    while (my ($k, $v) = each %$state) {
        writedata("$path/$k", $v);
    }
}

sub writelist {
    my ($path, $state) = @_;

    mkdir $path; # or die "Error creating $path: $!";

    for my $k (0 .. $#$state) {
        my $v = $state->[$k];
        writedata("$path/$k", $v);
    }
}

sub writefile {
    my ($path, $state) = @_;

    open(F, '>', $path) or die "Error opening $path for write: $!\n";
    print F $state;
}

sub readdata {
    my ($path) = @_;

    die "file or directory '$path' does not exist" unless -e $path;
    return readfile($path) if -f $path;
    die "path '$path' is not a file or directory" unless -d $path;

    opendir(D, $path) or die "Error opening directory '$path': $!";
    my @entries = grep { /^[^.]/ } readdir(D);

    return undef unless @entries; # XXX: should I support this?

    return readdirhash($path) if grep { !/^0|([1-9]\d*)$/ } @entries;
    return readdirlist($path);
}

sub readfile {
    my ($path) = @_;

    open(F, '<', $path) or die "Error opening file '$path' for read: $!";
    local $/;
    return <F>;
}

sub readdirhash {
    my ($path) = @_;
    my $data = {};

    opendir(D, $path);
    for (grep {/^[^.]/} readdir(D)) {
        $data->{$_} = readdata("$path/$_");
    }

    return $data;
}

sub readdirlist {
    my ($path) = @_;
    my $data = [];

    opendir(D, $path);
    for (grep {/^[^.]/} readdir(D)) {
        $data->[$_] = readdata("$path/$_");
    }

    return $data;
}

"Arbiter::Dir - was this really necessary?";
