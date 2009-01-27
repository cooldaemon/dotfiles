setlocal iskeyword+=:
setlocal complete=.,w,b,u,t,k
setlocal dictionary=~/.vim/dict/perl.dict

setlocal makeprg=~/.vim/tools/perl_checker.sh\ %

nmap <silent> <buffer> <Leader>d :%! perltidy -ce -pt=2 -sbt=2 -bt=2 -bbt=2 -nsfs -nolq<CR>

