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
  YAML::LoadFile($file_name);
};

if (!$@) {
  print 'Syntax OK!!', "\n";
  exit;
}

my ($message, $line, $col);
for (split /\n/, $@) {
    $_ =~ /YAML\sError:\s(.+)/ ? $message = $1
  : $_ =~ /Line:\s(\d+)/       ? $line    = $1
  : 1;
}

print sprintf('%s:%s:%s', $file_name, $line, $message), "\n";

