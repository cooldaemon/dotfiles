use strict;
use warnings;

if (!@ARGV) {
    print 'usage: js_dict_maker.pl [js files..]', "\n";
    exit;
}

my @keywords;
for (@ARGV) {
    push @keywords, analyse( $_ );
}
make_dict( @keywords );

exit;

sub analyse {
    my ($file) = @_;

    open( my $js_fh, '<' . $file ) or return;
    my $js_data;
    while (<$js_fh>) {
        $js_data .= $_;
    }
    close $js_fh;

    my @keywords;
    for my $reg (
        qw|
            function\s+([^\s\(]+)\s*\(
            ([^\s]+)\s*:\s*function\s*\(
            ([^\s]+)\s*=\s*function\s*\(
            ([^\s]+)\s*=\s*{
        |
    ) {
        while ($js_data =~ /$reg/g) {
            for my $name (split /\./, $1) {
                next if $name =~ /^_/;
                push @keywords, $name;
            }
        }
    }

    return @keywords;
}

sub make_dict {
    my %flag_of;
    for (@_) {
        $flag_of{$_} = 1;
    }

    my @keywords = sort { $a cmp $b } keys %flag_of;

    open( my $dict_fh, '>./js.dict' ) or die q{dict file not opened.};
    for (@keywords) {
        print $dict_fh $_ . "\n";
    }
    close $dict_fh;
}
