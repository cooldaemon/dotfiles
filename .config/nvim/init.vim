"==<etc>====================================================================
set backupdir=~/.cache/nvim/backup
let &directory = &backupdir

set shortmess+=I
set cmdheight=1
set hidden
set history=256
set diffopt=filler,icase,iwhite

if exists('+relativenumber')
  set rnu
  set nu
else
  set nonu
endif

if has('persistent_undo')
  set undodir=~/.cache/nvim/undo
  set undofile
endif

if has('kaoriya')
  set iminsert=1 imsearch=0
endif

set nocompatible
syntax on

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
set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column

nmap g/ :grep  \| cw5<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

nnoremap * g*N
nnoremap # g#N

nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"==<status line>============================================================
set laststatus=2
set wildmode=list:full
set ruler
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P

"==<color>==================================================================
"colorscheme molokai
colorscheme xoria256

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
      let &fileencodings = 'guess,ucs-bom,utf-8,'. s:enc_jis .','. s:enc_euc .',cp932,euc-jp,latin1'
    else
      let &fileencodings = 'guess,'. &fileencodings .','. s:enc_jis
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

fun! AU_ReCheck_FENC()
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

"==<change dir>=============================================================
command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>') 
fun! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfun

"==<dein>==================================================================
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = expand('~/.cache/dein')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.config/nvim/dein')
  let s:toml = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin on
filetype indent on

"==<plugin>================================================================
" denite
nmap ;; :Denite
nmap ;b :Denite buffer
nmap ;f :Denite file

" deoplate
let g:deoplete#enable_at_startup = 1
