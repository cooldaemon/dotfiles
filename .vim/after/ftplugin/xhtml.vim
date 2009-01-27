setlocal softtabstop=2
setlocal shiftwidth=2
setlocal tabstop=2

setlocal matchpairs+=<:>

nmap <silent> <buffer> <leader>f :w<CR>:!~/bin/reload_firefox.sh<CR>

