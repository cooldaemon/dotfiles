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

let mapleader = ','

"==<tabkey>=================================================================
set cindent
set expandtab

set softtabstop=4
set shiftwidth=4
set tabstop=4

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
set wildmode=list:full
set ruler
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"==<color>==================================================================
colorscheme desert

set listchars=tab:>_
set list

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
endf

autocmd BufReadPost * call AU_ReCheck_FENC()

set fileformats=unix,dos,mac
set ambiwidth=double

command! -nargs=? -complete=file -bang -bar Utf8 edit<bang> ++enc=utf-8 <args>
command! -nargs=? -complete=file -bang -bar Cp932 edit<bang> ++enc=cp932 <args>
command! -nargs=? -complete=file -bang -bar Sjis edit<bang> ++enc=sjis <args>
command! -nargs=? -complete=file -bang -bar Eucjpms edit<bang> ++enc=eucjp-ms <args>
command! -nargs=? -complete=file -bang -bar Eucjp edit<bang> ++enc=euc-jp <args>
command! -nargs=? -complete=file -bang -bar Iso2022jp3 edit<bang> ++enc=iso-2022-jp-3 <args>
command! -nargs=? -complete=file -bang -bar Iso2022jp edit<bang> ++enc=iso-2022-jp <args>

"==<complete>===============================================================
set isfname-=-
set complete=.,w,b,u,t,i

set omnifunc=syntaxcomplete#Complete

imap <C-o> <C-x><C-o>
imap <C-l> <C-x><C-l>

"==<buffer>=================================================================
nmap <DOWN> :bn!<CR>
nmap <UP> :bp!<CR>
nmap gj :bn!<CR>
nmap gk :bp!<CR>

"==<tab>====================================================================
nmap <Leader>t :tabnew<CR>
nmap <Leader>T :tabclose<CR>
nmap <RIGHT> :tabn<CR>
nmap <LEFT> :tabp<CR>
nmap gl :tabn<CR>
nmap gh :tabp<CR>

highlight TabLine term=reverse cterm=reverse ctermfg=white ctermbg=black
highlight TabLineSel term=bold cterm=bold,underline ctermfg=5
highlight TabLineFill term=reverse cterm=reverse ctermfg=white ctermbg=black

"==<syntax check>===========================================================
nmap <Leader>m :w<CR>:make<CR>:cw5<CR>

"==<move>===================================================================
noremap j gj
noremap k gk

"==<pair>===================================================================
set showmatch

inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap [ <C-R>=AddPair('[')<CR>
inoremap < <C-R>=AddPair('<')<CR>

function! AddPair(char)
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

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<RIGHT>"
  else
    return a:char
  endif
endf

function! ClosePairHtml(char)
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

"==<plugin>=================================================================
"rails
let g:rubycomplete_rails = 1
let g:rails_level = 4
let g:rails_devalut_database = 'mysql'

"project
nmap <silent><Leader>p <Plug>ToggleProject

"autocomplpop
autocmd BufNewFile,BufRead,BufEnter * call SetAutoComplOption()

function! SetAutoComplOption()
  if &syntax == 'perl'
    let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k'
  elseif &syntax != 'qf'
    let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k'
  endif
endf

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

"fuzzyfinder
nmap gb :FuzzyFinderBuffer<CR>
nmap <Leader>fb :FuzzyFinderBuffer<CR>
nmap <Leader>ff :FuzzyFinderFile<CR>
nmap <Leader>fd :FuzzyFinderDir<CR>
nmap <Leader>ft :FuzzyFinderTag<CR>

"git-commit
let git_diff_spawn_mode=1
autocmd BufNewFile,BufRead,BufEnter COMMIT_EDITMSG set filetype=git

"haskell
autocmd BufEnter *.hs compiler ghc
let g:haddock_browser = "open -a firefox"

"smartword
map w  <Plug>(smartword-w)
map b  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

