#!/usr/bin/env perl
use strict;
use warnings;

use Path::Class;
use File::HomeDir;

if (!@ARGV) {
    print $0, ' [Catalyst application root directory]', "\n";
    exit;
}

my $root_dir = Path::Class::Dir->new($ARGV[0]);
my $app_dir  = create_app_dir($root_dir);
for ($root_dir, $app_dir) {
    if (!-d $_) {
        print $_, ' is not directory.', "\n";
        exit;
    }
}

my $dir_of = create_mvc_dir($root_dir, $app_dir);
for (qw(Model View Controller)) {
    if (!$dir_of->{$_}) {
        print $_, 'directory is not exist.', "\n";
        exit;
    }
}

exec_screen($root_dir, $dir_of,);
exit;

sub create_app_dir {
    my ($root_dir) = @_;
    my @dirs = $root_dir->dir_list;
    my $dir = pop @dirs;
    $dir =~ s{-}{/}g;
    return Path::Class::Dir->new($root_dir, 'lib', $dir,);
}

sub create_mvc_dir {
    my ($root_dir, $app_dir) = @_;
    my %dir_of;

    my $check_dir = $app_dir;
    while ($root_dir->subsumes($check_dir)) {
        my $m_dir = Path::Class::Dir->new($check_dir, 'Schema',);
        if (-d $m_dir) {
            $dir_of{Model} = $m_dir;
            last;
        }
        $check_dir = $check_dir->parent;
    }

    for (qw(Model Controller)) {
        next if $dir_of{$_};
        $dir_of{$_} = create_mc_dir($app_dir, $_,);
    }

    my $v_dir = Path::Class::Dir->new($root_dir, 'root');
    $dir_of{View} = -d $v_dir ? $v_dir : '';

    return \%dir_of;
}

sub create_mc_dir {
    my ($app_dir, $target,) = @_;

    for ($target, substr($target, 0, 1),) {
        my $dir = Path::Class::Dir->new($app_dir, $_,);
        next if !-d $dir;
        return $dir;
    }
    return;
}

sub exec_screen {
    my ($root_dir, $dir_of,) = @_;
    
    my $rc_fh = Path::Class::File->new(
        File::HomeDir->my_home, '.screenrc'
    )->open('r') or die "Can't read .screenrc: $!";

    my $rc = join '', $rc_fh->getlines;
    $rc_fh->close;

    my $tmp_file = Path::Class::File->new(
        File::HomeDir->my_home, '.screenrc.tmp'
    );
    my $tmp_fh
        = $tmp_file->open('w') or die "Can't write .screenrc.tmp: $!";

    $tmp_fh->print(<<"__END_OF_SCREENRC__");
$rc

bind ^c eval "echo 'Change directory: [r:Root] [m:Model] [v:View] [c:Controller]'" "command -c changer"
bind -c changer ^a command
__END_OF_SCREENRC__

    print_cd_lines($tmp_fh, $root_dir, 'r',);
    for (qw(Model View Controller)) {
        print_cd_lines($tmp_fh, $dir_of->{$_}, lc(substr($_, 0, 1,)),);
    }
    $tmp_fh->print('select 0', "\n");

    $tmp_fh->close;

    `screen -c $tmp_file`;
    $tmp_file->remove();
}

sub print_cd_lines {
    my ($fh, $dir, $key,) = @_;
    my $abs = $dir->absolute;
    my $change_directory = "stuff 'cd $abs'";

    $fh->print(<<"__END_OF_SCREENRC__");
screen
$change_directory
bind -c changer $key $change_directory
__END_OF_SCREENRC__
}

