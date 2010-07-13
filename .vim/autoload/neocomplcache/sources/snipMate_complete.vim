let s:source = {
      \ 'name' : 'snipMate_complete',
      \ 'kind' : 'plugin',
      \}

function! s:source.initialize()
  let s:snip_list = {}
endfunction

function! s:source.finalize()
endfunction

function! s:source.get_keyword_list(cur_keyword_str)
  let snips = GetSnippetsList(&filetype)
  if empty(snips)
    return []
  endif

  let ft = empty(&filetype) ? '_' : &filetype
  if !has_key(s:snip_list, ft)
    let l:abbr_pattern = printf('%%.%ds..%%s', g:neocomplcache_max_keyword_width-10)
    let l:menu_pattern = '<S> %.'.g:neocomplcache_max_filename_width.'s'

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
        \ (len(l:abbr) > g:neocomplcache_max_keyword_width) ?
        \ printf(l:abbr_pattern, l:abbr, l:abbr[-8:]) : l:abbr

      let l:menu = printf(l:menu_pattern, trig)

      let list += [{'word' : trig, 'menu' : l:menu, 'prev_word' : ['^'],
        \ 'rank' : 1, 'prev_rank' : 0, 'prepre_rank' : 0, 'abbr' : l:abbr}]
    endfor
    let s:snip_list[ft] = list
  else
    let list = s:snip_list[ft]
  endif

  return neocomplcache#keyword_filter(copy(list), a:cur_keyword_str)
endfunction

function! neocomplcache#sources#snipMate_complete#define()
  return s:source
endfunction

