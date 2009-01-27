setlocal softtabstop=2
setlocal shiftwidth=2
setlocal tabstop=2

setlocal makeprg=~/.vim/tools/css_checker.pl\ %

nmap <silent> <buffer> <leader>f :w<CR>:!~/bin/reload_firefox.sh<CR>

