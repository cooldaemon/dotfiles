#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(:5.10);

use version; our $VERSION = qv('0.0.1');

use Carp;
use English qw(-no_match_vars);

use Path::Class qw(dir);
use HTML::TreeBuilder::XPath;
use List::MoreUtils qw(uniq);

my $tree = HTML::TreeBuilder::XPath->new;
my @elements = qw(
    ArgumentError arguments Array Boolean Class Date DefinitionError
    Error EvalError Function int Math Namespace Number Object QName
    RangeError ReferenceError RegExp SecurityError String SyntaxError
    TypeError uint URIError VerifyError XML XMLList
);

dir(
    '/Users/ikuta/Documents/flex3',
    'livedocs.adobe.com', 'flex', '3_jp', 'langref', 'mx',
)->recurse(
    callback => sub {
        my ($file) = @_;

        return if ! -f $file || $file->basename ne 'class-list.html';

        $tree->parse_file("$file");
        for ($tree->findnodes('/html/body/table/tr/td/a/text()')) {
            push @elements, $_->getValue();
        }
    }
);

say join "\n", map {'mx:' . $_} sort {$a cmp $b} uniq @elements;

