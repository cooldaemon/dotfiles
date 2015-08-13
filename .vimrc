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
  set nu
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

"==<NeoBundle>=================================================================
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'sgur/unite-qf'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'kana/vim-smartword'
NeoBundle 'othree/eregex.vim'
NeoBundle 'sql_iabbr-2'
NeoBundle 'errormarker.vim'
NeoBundle 'project.tar.gz'
NeoBundle 'surround.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'commentop.vim'
NeoBundle 'git-commit'
NeoBundle "scrooloose/syntastic"
NeoBundle 'tell-k/vim-autopep8'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'davidhalter/jedi-vim'

call neobundle#end()

filetype plugin on
filetype indent on

NeoBundleCheck

"==<plugin>=================================================================
"project
nmap <silent><Leader>p <Plug>ToggleProject

"unite
nmap ;; :Unite 
nmap ;s :Unite source<CR>
nmap ;b :Unite buffer<CR>
nmap ;f :Unite file<CR>
nmap ;r :Unite ref/
nmap ;q :Unite qf<CR>

nmap ;/ :grep  \| Unite qf<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

"git-commit
let git_diff_spawn_mode=1

"syntastic
let g:syntastic_python_checkers = ["flake8"] " pip install hacking
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

"smartword
map w  <Plug>(smartword-w)
map b  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

"jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

"neosnippet
let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
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

if !exists('g:neocomplete#same_filetypes')
  let g:neocomplete#same_filetypes = {}
endif
let g:neocomplete#same_filetypes.c = 'ref-man,ref-erlang'
let g:neocomplete#same_filetypes.perl = 'ref-perldoc'
let g:neocomplete#same_filetypes.ruby = 'ref-refe'
let g:neocomplete#same_filetypes.erlang = 'ref-erlang'
let g:neocomplete#same_filetypes.objc = 'c'
let g:neocomplete#same_filetypes.tt2html = 'html,perl'
let g:neocomplete#same_filetypes['int-erl'] = 'erlang,ref-erlang'
let g:neocomplete#same_filetypes['int-perlsh'] = 'perl,ref-perldoc'
let g:neocomplete#same_filetypes['int-irb'] = 'ruby,ref-refe'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"vim-ref
let g:ref_open = 'tabnew'

"yankring
let g:yankring_history_dir = '~/.vim/bundle/YankRing.vim/'

"vim-indent-guides
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#262626 ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=black
