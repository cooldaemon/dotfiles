#!/usr/bin/env perl

use strict;
use warnings;

use List::MoreUtils qw(uniq);
use URI;
use Web::Scraper;
use Path::Class;
use File::HomeDir;

my $scraper = scraper {
    process '//html/body/p/table/tr/td[3]/a', 'functions[]' => 'text';
    result 'functions';
};

my @funcs;
for ('a'..'z') {
    my $scraped_funcs = $scraper->scrape(URI->new(
        'http://www.erlang.org/doc/permuted_index/pidx' . $_ . '.html'
    ));
    push @funcs, @$scraped_funcs;
}

my $base_fh = Path::Class::File->new(
    File::HomeDir->my_home, qw(.vim dict erlang_base.dict)
)->openr or die $!;
push @funcs, (map {s/\n$//; $_} $base_fh->getlines);
$base_fh->close;

my $fh = Path::Class::File->new(
    File::HomeDir->my_home, qw(.vim dict erlang.dict)
)->openw or die $!;

$fh->print($_, "\n") for sort {$a cmp $b} grep {!/^erlang:/} uniq map {s{/\d+$}{};$_;} @funcs;

$fh->close;

