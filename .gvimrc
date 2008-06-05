set lines=50
set cmdheight=1

if has('mac')
  set columns=160
  set guifont=Osaka|“™•:h16
  set nomacatsui
  autocmd VimEnter * :vsplit
else
  set columns=87
endif

"set transparency=200
set transparency=235
set guioptions=egmtT

gui
colorscheme xoria256
