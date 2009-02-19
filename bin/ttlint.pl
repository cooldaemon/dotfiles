#!/usr/bin/env perl

use strict;
use warnings;

use Path::Class qw(file);
use Template::Parser;

my $file   = file(shift);
my $source = $file->slurp;
my $parser = Template::Parser->new;

if ($parser->parse($source)) {
    print 'Syntax OK', "\n";
    exit;
}

my $error = $parser->error;
$error =~ s/^line\s(\d+):\s/${1}:/;
$error =~ s/\n//g;
$error =~ s/\s{2,}/ /g;

print $file->absolute, ':', $error, "\n";

