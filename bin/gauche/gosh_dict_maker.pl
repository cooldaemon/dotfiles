#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(:5.10);

use version; our $VERSION = qv('0.0.1');

use Carp;
use English qw(-no_match_vars);

use FindBin qw($Bin);
use Path::Class;
use List::MoreUtils qw(uniq);

use Readonly;
Readonly my $MODULES_FILE     => $Bin . '/gauche_modules';
Readonly my $COMPLETIONS_FILE => $Bin . '/gosh_completions';

make_modules_file(get_modules(@ARGV));
make_dict_file();
exit;

sub get_modules {
    my @dirs = @_;
    my @modules;
    for my $dir (@dirs) {
        next if ! -e $dir;
        dir($dir)->recurse(
            callback => sub {
                my $file = shift;
                return if $file->is_dir;

                $file = substr "$file", length($dir) + 1;
                return if $file !~ /\.scm$/mx;

                $file =~ s{\.scm$}{}mx;
                $file =~ s{/}{.}mxg;
                push @modules, $file;
            }
        );
    }
    return \@modules;
}

sub make_modules_file {
    my $modules = shift;

    my $fh = file($MODULES_FILE)->openw or croak $OS_ERROR;
    $fh->print(
        join "\n", sort {$a cmp $b} uniq @$modules
    ) or croak $OS_ERROR;
    $fh->close or croak $OS_ERROR;
}

sub make_dict_file {
    return if ! -e $MODULES_FILE;

    my $fh = file($COMPLETIONS_FILE)->openw or croak $OS_ERROR;

    $fh->print(
        join "\n", sort {$a cmp $b} grep {1 < length($_)}
            uniq split /\n/, `cat $MODULES_FILE | $Bin/gosh_dict_maker.scm`
    );

    $fh->close or croak $OS_ERROR;
}

