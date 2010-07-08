let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ref_twitter_encoding')
  let g:ref_twitter_encoding = &termencoding
endif

let s:source = {'name': 'twitter'}

function! s:source.available()
  return 1
endfunction

function! s:source.get_body(query)
  let cmd = 'search_twitter.pl ' . s:iconv(a:query, &encoding, 'utf-8')
  let res = ref#system(cmd).stdout
  return s:iconv(res, g:ref_twitter_encoding, &encoding)
endfunction

function! s:source.opened(query)
  execute "normal! 1G\<CR>"
  call s:syntax()
endfunction

function! s:source.normalize(query)
  return substitute(substitute(a:query, '\_s\+', ' ', 'g'), '^ \| $', '', 'g')
endfunction

function! s:iconv(expr, from, to)
  if a:from == '' || a:to == '' || a:from ==# a:to
    return a:expr
  endif
  let result = iconv(a:expr, a:from, a:to)
  return result != '' ? result : a:expr
endfunction

function! ref#twitter#define()
  return s:source
endfunction

function! s:syntax()
  let register_save = @"

  let color_map = {
    \ 0 : 'Black',
    \ 1 : 'Red',
    \ 2 : 'Green',
    \ 3 : 'Yellow',
    \ 4 : 'Blue',
    \ 5 : 'Magenta',
    \ 6 : 'Cyan',
    \ 7 : 'White'
    \ }

  while search('\[[0-9;]*m', 'c')
    execute 'normal! dfm'

    let [lnum, col] = getpos('.')[1:2]

    let pos = len(matchstr(getline('.'), '.', col('.') - 1)) + col - 1
    let len = len(getline('.'))

    if len == col || len == pos
      let col = 1
      let lnum += 1
    endif

    let syntax_name = 'ConsoleCodeAt_' . bufnr('%') . '_' . lnum . '_' . col
    execute 'syntax region' syntax_name 'start=+\%' . lnum . 'l\%' . col . 'c+ end=+\%$+' 'contains=ALL'

    let highlight = ''
    for color_code in split(matchstr(@", '[0-9;]\+'), ';')
      if color_code == 0
        let highlight .= ' ctermfg=NONE ctermbg=NONE'
        let highlight .= ' guifg=NONE guibg=NONE'
      elseif color_code == 1
        let highlight .= ' cterm=bold'
        let highlight .= ' gui=bold'
      elseif 30 <= color_code && color_code <= 37
         let highlight .= ' ctermfg=' . (color_code - 30)
         let highlight .= ' guifg=' . color_map[(color_code - 30)]
      elseif 40 <= color_code && color_code <= 47
        let highlight .= ' ctermbg=' . (color_code - 40)
        let highlight .= ' guibg=' . color_map[(color_code - 40)]
      endif
    endfor

    if len(highlight)
      execute 'highlight' syntax_name highlight
    endif
  endwhile

  let @" = register_save
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
