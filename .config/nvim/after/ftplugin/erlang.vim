setlocal softtabstop=2
setlocal shiftwidth=2
setlocal tabstop=2

setlocal iskeyword+=:
setlocal complete=.,w,b,u,t,i,k
setlocal dictionary=~/.vim/dict/erlang.dict

setlocal makeprg=erlc\ %

