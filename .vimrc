"==<etc>====================================================================
set backupdir=~/.vimbackup
let &directory = &backupdir

set shortmess+=I
set cmdheight=1
set hidden
set history=256
set diffopt=filler,icase,iwhite

if exists('+relativenumber')
  set rnu
else
  set nonu
endif

if has('persistent_undo')
  set undodir=~/.vimundo
  set undofile
endif

if has('kaoriya')
  set iminsert=1 imsearch=0
endif

helptags ~/.vim/doc

set nocompatible
syntax on
filetype plugin on
filetype indent on

let mapleader = ','

autocmd BufNewFile,BufRead,BufEnter * exec ':lcd ' . expand("%:p:h")

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

nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"==<status line>============================================================
set laststatus=2
set wildmode=list:full
set ruler
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P

"==<color>==================================================================
colorscheme desert

set listchars=tab:>_
set list

"==<encode>=================================================================
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

if !has('kaoriya')
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
endif

function! AU_ReCheck_FENC()
  if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
    let &fileencoding=&encoding
  endif
endf

if !has('kaoriya')
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

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
set completeopt=menu,preview,menuone
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
nnoremap j gj
onoremap j gj
xnoremap j gj

nnoremap k gk
onoremap k gk
xnoremap k gk

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

"fuzzyfinder
nmap gb :FufBuffer<CR>
nmap <Leader>fb  :FufBuffer<CR>
nmap <Leader>ff  :FufFile<CR>
nmap <Leader>fd  :FufDir<CR>
nmap <Leader>fb  :FufBookmark<CR>
nmap <Leader>fab :FufAddBookmark<CR>
nmap <Leader>fe  :FufEditInfo<CR>
nmap <Leader>ft  :FufTag<CR>

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

"neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_plugin_completion_length = {
  \ 'snipMate_complete' : 1,
  \ 'buffer_complete'   : 2,
  \ 'include_complete'  : 2,
  \ 'syntax_complete'   : 2,
  \ 'filename_complete' : 2,
  \ 'keyword_complete'  : 2,
  \ 'omni_complete'     : 1
  \ }
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default'    : '',
  \ 'erlang'     : $HOME . '/.vim/dict/erlang.dict',
  \ 'objc'       : $HOME . '/.vim/dict/objc.dict',
  \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
  \ 'mxml'       : $HOME . '/.vim/dict/mxml.dict',
  \ 'ruby'       : $HOME . '/.vim/dict/ruby.dict',
  \ 'perl'       : $HOME . '/.vim/dict/perl.dict',
  \ 'scheme'     : $HOME . '/.vim/dict/gauche.dict',
  \ 'scala'      : $HOME . '/.vim/dict/scala.dict',
  \ 'int-erl'    : $HOME . '/.vim/dict/erlang.dict',
  \ 'int-irb'    : $HOME . '/.vim/dict/ruby.dict',
  \ 'int-perlsh' : $HOME . '/.vim/dict/perl.dict'
  \ }
let g:neocomplcache_same_filetype_lists = {
  \ 'c'          : 'ref-man,ref-erlang',
  \ 'perl'       : 'ref-perldoc',
  \ 'ruby'       : 'ref-refe',
  \ 'erlang'     : 'ref-erlang',
  \ 'objc'       : 'c',
  \ 'tt2html'    : 'html,perl',
  \ 'int-erl'    : 'erlang,ref-erlang',
  \ 'int-perlsh' : 'perl,ref-perldoc',
  \ 'int-irb'    : 'ruby,ref-refe'
  \ }

autocmd BufFilePost \[ref-* silent execute ":NeoComplCacheCachingBuffer"

"vimshell
let g:vimshell_split_command = 'split'
let g:vimshell_smart_case = 1
let g:vimshell_prompt = $USER."% "
let g:vimshell_user_prompt = 'printf("%s %s", fnamemodify(getcwd(), ":~"), vimshell#vcs#info("(%s)-[%b]"))'

autocmd FileType vimshell
  \ call vimshell#hook#set('chpwd', ['g:chpwd_for_vimshell'])

function! g:chpwd_for_vimshell(args, context)
  call vimshell#execute('ls')
endfunction

"ref
let g:ref_open = 'tabnew'

