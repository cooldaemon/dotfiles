#!/usr/bin/perl

use strict;
use warnings;

use Readonly;
use File::Find 'find';

Readonly my $LIST_DIR  => "$ENV{HOME}/.vim/dict/";
Readonly my $LIST_FILE => "perl_extras.dict";

die "plz make $LIST_DIR\n" if ! -e $LIST_DIR;
open my $fh, q{>}, "$LIST_DIR$LIST_FILE" or die "couldn't open $LIST_FILE\n";

my %already_seen;
for my $inc_dir (@INC) {
    next if ! -e $inc_dir;
    find {
        wanted => sub {
            my $file = $_;
            return if !($file =~ m{\.pm\z});

            $file =~ s{^\Q$inc_dir/\E}{};
            $file =~ s{/}{::}g;
            $file =~ s{\.pm\z}{};

            $file =~ s{^.*\b[a-z_0-9]+::}{};
            $file =~ s{^\d+\.\d+\.\d+::(?:[a-z_][a-z_0-9]*::)?}{};
            return if $file =~ m{^::};

            print {$fh} $file, "\n" if ! $already_seen{$file}++;
        },
        no_chdir => 1,
    }, $inc_dir;
}

close $fh;

`cat ${LIST_DIR}perl_base.dict $LIST_DIR$LIST_FILE | sort > ${LIST_DIR}perl.dict`;
