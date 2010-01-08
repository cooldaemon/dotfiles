set lines=50
set cmdheight=1

if has('gui_macvim')
  set columns=180
  autocmd VimEnter * :vsplit
  set guifont=Monaco:h14
  set imdisable
  set transparency=10
  set guioptions=egmt

  " for vimshell
  let g:VimShell_EnableInteractive = 1
  let g:VimShell_EnableSmartCase = 1
  let g:VimShell_EnableAutoLs = 1
  let g:VimShell_Prompt = $USER."% "
  let g:VimShell_UserPrompt = 'printf("%s %50s", fnamemodify(getcwd(), ":~"), vimshell#vcs#info("(%s)-[%b]"))'
elseif has('mac')
  set columns=160
  autocmd VimEnter * :vsplit
  set guifont=OsakaÅ|ìôïù:h16
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

