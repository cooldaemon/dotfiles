#!/usr/bin/env perl

package ObjcDictMaker;

use feature qw(:5.10);
use version; our $VERSION = qv('0.0.1');

use FindBin;
use List::MoreUtils qw(uniq);

use Any::Moose;
use Any::Moose 'X::Types::Path::Class';

with any_moose('X::Getopt');

has 'in' => (
    is            => 'ro',
    isa           => 'Path::Class::Dir',
    required      => 1,
    coerce        => 1,
    documentation => 'analyzed directory.',
);

has 'out' => (
    is            => 'ro',
    isa           => 'Path::Class::File',
    default       => $FindBin::RealBin . '/objc.dict',
    coerce        => 1,
    documentation => 'dictionary file name.',
);

__PACKAGE__->meta->make_immutable;
no Any::Moose;

sub run {
    my $self = shift;

    my @keywords;
    $self->in->recurse(callback => sub {
        my $file = shift;
        return if !-f $file;
        return if $file !~ /\.h$/;

        push @keywords, @{$self->_analyze($file)};
        return;
    });

    my $out_fh = $self->out->openw or die $!;
    $out_fh->print(join("\n", (sort {$a cmp $b} uniq @keywords),), "\n",);
    $out_fh->close;
    return;
}

sub _analyze {
    my $self = shift;
    my ($file,) = @_;

    my $class_name = $file->basename;
    $class_name =~ s/\.[^.]$//;
    say $class_name;
    my @keywords = ($class_name);

    my $fh = $file->openr or return;
    while (my $line = $fh->getline) {
        $line =~ s/^\s*//;
        $line =~ s/\n$//;
        next if $line !~ /^[-+]/;

        $line =~ s/^([^;]+);.*$/$1/;
        $line =~ s/^[-+]\s*\(\s*[^)]+\s*\)\s*//;
        $line =~ s/\(\s*[^)]+\s*\)//g;

        push
            @keywords,
            uniq (grep {/^\w/} map {$_ =~ s/:[^:]+$//; $_} split(/\s+/, $line))
            ;
    }
    $fh->close;

    return \@keywords;
}

package main;

my $objc_dict_maker = eval {ObjcDictMaker->new_with_options()}
    or die 'usage: ', $FindBin::RealScript, ' -in [analyzed directory]';

$objc_dict_maker->run();
exit;

