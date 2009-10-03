" A plugin for neocomplecache to complete snipMate snippets.
" Version: 0.0
" Author : thinca <http://d.hatena.ne.jp/thinca/>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>


let s:save_cpo = &cpo
set cpo&vim


function! neocomplcache#plugin#snipMate_complete#initialize() "{{{
  " Initialize
  let s:snip_list = {}
endfunction "}}}

function! neocomplcache#plugin#snipMate_complete#finalize() "{{{
endfunction "}}}

function! neocomplcache#plugin#snipMate_complete#get_keyword_list(cur_keyword_str) "{{{
  let snips = GetSnippetsList(&filetype)
  if empty(snips)
    return []
  endif

  let ft = empty(&filetype) ? '_' : &filetype
  if !has_key(s:snip_list, ft)
    let l:abbr_pattern = printf('%%.%ds..%%s', g:NeoComplCache_MaxKeywordWidth-10)
    let l:menu_pattern = '<S> %.'.g:NeoComplCache_MaxFilenameWidth.'s'

    let list = []
    for trig in keys(snips)
      if type(snips[trig]) == type([])
        let s:triger = 'multi snips - ' . snips[trig][0][1]
      else
        let s:triger = snips[trig]
      endif

      let l:abbr = substitute(
        \ substitute(s:triger, '\n', '', 'g'),
        \ '\s', ' ', 'g')
      let l:abbr =
        \ (len(l:abbr) > g:NeoComplCache_MaxKeywordWidth) ?
        \ printf(l:abbr_pattern, l:abbr, l:abbr[-8:]) : l:abbr

      let l:menu = printf(l:menu_pattern, trig)

      let list += [{'word' : trig, 'menu' : l:menu, 'prev_word' : ['^'],
        \ 'rank' : 1, 'prev_rank' : 0, 'prepre_rank' : 0, 'abbr' : l:abbr}]
    endfor
    let s:snip_list[ft] = list
  else
    let list = s:snip_list[ft]
  endif

  return s:keyword_filter(copy(list), a:cur_keyword_str)
endfunction "}}}

" Dummy function.
function! neocomplcache#plugin#snipMate_complete#calc_rank(cache_keyword_buffer_list) "{{{
endfunction "}}}
function! neocomplcache#plugin#snipMate_complete#calc_prev_rank(cache_keyword_buffer_list, prev_word, prepre_word) "{{{
endfunction "}}}

" Internal function.
function! s:keyword_filter(list, cur_keyword_str) "{{{
    let l:skipped = neocomplcache#skipped()
    let l:keyword_escape = neocomplcache#keyword_escape(a:cur_keyword_str)

    " Keyword filter."{{{
    if g:NeoComplCache_PartialMatch && !l:skipped && len(a:cur_keyword_str) >= g:NeoComplCache_PartialCompletionStartLength
        " Partial match.
        " Filtering len(a:cur_keyword_str).
        let l:pattern = printf("v:val.word =~ %s", string(l:keyword_escape))
    else
        " Head match.
        " Filtering len(a:cur_keyword_str).
        let l:pattern = printf("v:val.word =~ %s", string('^' . l:keyword_escape))
    endif"}}}

    return filter(a:list, l:pattern)
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
