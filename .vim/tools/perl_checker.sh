~/.vim/tools/efm_perl.pl -c $1
perlcritic -1 -verbose 1 -exclude RequireRcsKeywords -exclude RequireTidyCode $1
