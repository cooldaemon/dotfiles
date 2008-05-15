#!/usr/bin/perl
use strict;
use warnings;

use YAML;

my $file_name = $ARGV[0];
if (!$file_name) {
  print "Usage : yaml_checker.pl [YAML file name]\n";
  exit;
}

eval {
  YAML::LoadFile( $file_name );
};

$@ ? print $@ : print q{Syntax OK!!};
print "\n";
