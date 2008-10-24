set lines=50
set cmdheight=1

if has('gui_macvim')
  set columns=180
  autocmd VimEnter * :vsplit
  set guifont=Monaco:h14
  set imdisable
  set transparency=10
  set guioptions=egmt
elseif has('mac')
  set columns=160
  autocmd VimEnter * :vsplit
  set guifont=Osaka|“™•:h16
  set nomacatsui
  set transparency=235
  set guioptions=egmtT
else
  set columns=87
  set transparency=235
  set guioptions=egmtT
endif

gui
colorscheme xoria256

