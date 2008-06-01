"==<etc>====================================================================
set backupdir=~/.vim/backup
let &directory = &backupdir

set shortmess+=I
set nu!
set cmdheight=1
set hidden
set history=256
set diffopt=filler,icase,iwhite

if has('kaoriya')
  set iminsert=1 imsearch=0
endif

helptags ~/.vim/doc

set nocompatible
syntax on
filetype plugin on
filetype indent on

autocmd FileType perl set isfname-=-

nmap ,u :w<CR>:!~/bin/deploy.pl %<CR>

"==<tabkey>=================================================================
set cindent
set expandtab

autocmd BufEnter * call SetTab()

function SetTab()
  if &syntax == 'javascript' || &syntax == 'ruby' || &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'css' || &syntax == 'tt2html' || &syntax == 'eruby' || &syntax == 'yaml' || &syntax == 'vim'
    execute 'set softtabstop=2 | set shiftwidth=2 | set tabstop=2'
  else
    execute 'set softtabstop=4 | set shiftwidth=4 | set tabstop=4'
  endif
endf

"==<search>=================================================================
set magic
set ignorecase
set smartcase
"set hlsearch
set incsearch
set grepprg=internal

"nmap <silent> gh :let @/=''<CR>
nmap g/ :grep // % \| cw5<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

nnoremap * g*N
nnoremap # g#N

"==<status line>============================================================
set laststatus=2
set wildmenu
set ruler
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"==<color>==================================================================
colorscheme desert

set listchars=tab:>_
set list
highlight SpecialKey guifg=#555555

highlight Pmenu      ctermbg=DarkGreen
highlight PmenuSel   ctermbg=DarkBlue
highlight PmenuSbar  ctermbg=DarkRed

"==<encode>=================================================================
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif

  unlet s:enc_euc
  unlet s:enc_jis
endif

function! AU_ReCheck_FENC()
  if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
    let &fileencoding=&encoding
  endif
endfunction

autocmd BufReadPost * call AU_ReCheck_FENC()

set fileformats=unix,dos,mac
set ambiwidth=double

autocmd FileType cvs :set fileencoding=euc-jp
autocmd FileType svn :set fileencoding=utf-8

"==<complete>===============================================================
set iskeyword+=:
autocmd FileType * set complete=.,w,b,u,t,i
autocmd FileType perl set complete-=i | set complete+=k~/.vim/dict/perl.dict
autocmd FileType ruby set complete+=k~/.vim/dict/ruby.dict
autocmd FileType javascript set complete+=k~/.vim/dict/javascript.dict
autocmd FileType erlang set complete+=k~/.vim/dict/erlang.dict
autocmd FileType mxml set complete+=k~/.vim/dict/mxml.dict
autocmd FileType scheme set complete+=k~/.vim/dict/gauche.dict

set omnifunc=syntaxcomplete#Complete
autocmd FileType tt2html set omnifunc=htmlcomplete#CompleteTags

imap <C-o> <C-x><C-o>
imap <C-l> <C-x><C-l>

"==<buffer>=================================================================
nmap <LEFT> :bp!<CR>
nmap <RIGHT> :bn!<CR>
nmap gh :bp!<CR>
nmap gl :bn!<CR>

nmap gb :FuzzyFinderBuffer<CR>

"==<tab>====================================================================
nmap ,t :tabnew<CR>
nmap ,T :tabclose<CR>
nmap <DOWN> :tabn<CR>
nmap <UP> :tabp<CR>
nmap gj :tabn<CR>
nmap gk :tabp<CR>

highlight TabLine term=reverse cterm=reverse ctermfg=white ctermbg=black
highlight TabLineSel term=bold cterm=bold,underline ctermfg=5
highlight TabLineFill term=reverse cterm=reverse ctermfg=white ctermbg=black

"==<syntax check>===========================================================
nmap ,m :call SyntaxCheck()<CR>

function SyntaxCheck()
  if &syntax == 'perl'
    set makeprg=~/.vim/tools/perl_checker.sh\ %
  elseif &syntax == 'ruby'
    set makeprg=ruby\ -cW\ %
  elseif &syntax == 'javascript'
    set makeprg=/usr/local/bin/jslint\ --laxLineEnd\ %
  elseif &syntax == 'erlang'
    set makeprg=erlc\ %
  elseif &syntax == 'yaml'
    set makeprg=~/.vim/tools/yaml_checker.pl\ %
  elseif &syntax == 'html'
    set makeprg=tidy\ -quiet\ --errors\ --gnu-emacs\ yes\ %
  elseif &syntax == 'css'
    set makeprg=~/.vim/tools/css_checker.pl\ %
  endif

  execute ':w'
  execute ':make'
  execute ':cw5'
endf

nmap ,r :w<CR>:!~/bin/reload_firefox.sh<CR>
nmap ,pt :%! perltidy -ce -pt=2 -sbt=2 -bt=2 -bbt=2 -nsfs -nolq<CR>

"==<move>===================================================================
noremap j gj
noremap k gk

"==<pair>===================================================================
set showmatch
set matchpairs+=<:>

inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap [ <C-R>=AddPair('[')<CR>
inoremap < <C-R>=AddPair('<')<CR>

function AddPair(char)
  if a:char == '['
    if &syntax == 'tt2html'
      return "[%%]\<LEFT>\<LEFT>"
    else
      return "[]\<LEFT>"
    endif
  elseif a:char == '<'
    if &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'tt2html' || &syntax == 'eruby' || &syntax == 'vim'
      return "<>\<LEFT>"
    else
      return '<'
    endif
  endif
endf

inoremap ) <C-R>=ClosePair(')')<CR>
inoremap } <C-R>=ClosePair('}')<CR>
inoremap ] <C-R>=ClosePair(']')<CR>
inoremap > <C-R>=ClosePairHtml('>')<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<RIGHT>"
  else
    return a:char
  endif
endf

function ClosePairHtml(char)
  if &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'tt2html' || &syntax == 'eruby' || &syntax == 'vim'
    return ClosePair(a:char)
  else
    return a:char
  endif
endf

nmap ( csw(
nmap { csw{
nmap [ csw[

nmap ' csw'
nmap " csw"

"==<comment out>============================================================
nmap ,c :call CommentOut()<CR>

function CommentOut()
  if &syntax == 'perl' || &syntax == 'ruby' || &syntax == 'sh' || &syntax == 'yaml'
    execute ':s/^/#/'
  elseif &syntax == 'javascript'
    execute ':s/^/\/\//'
  elseif &syntax == 'erlang'
    execute ':s/^/%/'
  elseif &syntax == 'vim'
    execute ':s/^/"/'
  elseif &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'tt2html'
    execute ':s/^\(.*\)$/<!-- \1 -->/'
  endif

  execute ':nohlsearch'
endf

"==<plugin>=================================================================
let g:rubycomplete_rails = 1
let g:rails_level = 4
let g:rails_devalut_database = 'mysql'

nmap <silent>,p <Plug>ToggleProject

autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t'
autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'
autocmd FileType mxml let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/mxml.dict'
autocmd FileType scheme let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/gauche.dict'
autocmd FileType haskell let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'

let g:AutoComplPop_Behavior = {
  \   'haskell' : [
  \     {
  \       'command'  : "\<C-n>",
  \       'pattern'  : '\k\k$',
  \       'excluded' : '^$',
  \       'repeat'   : 0,
  \     },
  \     {
  \       'command'  : "\<C-x>\<C-o>",
  \       'pattern'  : '\k$',
  \       'excluded' : '^$',
  \       'repeat'   : 0,
  \     },
  \     {
  \       'command'  : "\<C-x>\<C-f>",
  \       'pattern'  : (has('win32') || has('win64') ? '\f[/\\]\f*$' : '\f[/]\f*$'),
  \       'excluded' : '[*/\\][/\\]\f*$\|[^[:print:]]\f*$',
  \       'repeat'   : 1,
  \     },
  \   ], 
  \ }

let g:AutoComplPop_IgnoreCaseOption = 1

let git_diff_spawn_mode=1
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git

autocmd Bufenter *.hs compiler ghc
let g:haddock_browser = "open -a firefox"

