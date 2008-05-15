use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => '<MAIN MODULE>',
    license             => '<LICENSE>',
    dist_author         => '<AUTHOR> <<EMAIL>>',
    dist_version_from   => '<MAIN PM FILE>',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ '<DISTRO>-*' ],
);

$builder->create_build_script();
