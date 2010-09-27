setlocal softtabstop=2
setlocal shiftwidth=2
setlocal tabstop=2

setlocal complete=.,w,b,u,t,i,k
setlocal dictionary=~/.vim/dict/javascript.dict

setlocal omnifunc=javascriptcomplete#CompleteJS

setlocal makeprg=~/bin/jslint.sh\ %

nmap <silent> <buffer> <leader>f :w<CR>:!~/bin/reload_firefox.sh<CR>

