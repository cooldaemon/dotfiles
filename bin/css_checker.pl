#!/usr/bin/perl
use strict;
use warnings;

use WebService::Validator::CSS::W3C;

my $file_name = $ARGV[0];
if (!$file_name) {
    print "Usage : css_checker.pl [CSS file name]\n";
    exit;
}

open my $fh, $file_name or die "Couldn't open $file_name: $!";
my $source;
while (<$fh>) {
  $source .= $_;
}
close $fh or die "Couldn't close $file_name: $!";

my $validator = WebService::Validator::CSS::W3C->new();
$validator->validate(
    string  => $source,
    warnings => 10,
) or die "Web Service response error.";

if (!$validator->errorcount && !$validator->warningcount) {
    print "Syntax OK!!\n";
    exit;
}

for my $string_of ($validator->errors, $validator->warnings) {
    print join(':', map {
        defined $string_of->{$_} ? $string_of->{$_} : '';
    } qw(line message)), "\n";
}
