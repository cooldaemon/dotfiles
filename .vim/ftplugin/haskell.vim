
" todo: allow disabling and undo
" (Claus Reinke, last modified: 21/08/2007)
"
" part of haskell plugins: http://www.cs.kent.ac.uk/~cr3/toolbox/haskell/Vim/

" try gf on import line, or ctrl-x ctrl-i, or [I, [i, ..
set include=^import\\s*\\(qualified\\)\\?\\s*
set includeexpr=substitute(v:fname,'\\.','/','g').'.hs'


" find start/extent of name/symbol under cursor;
" return start, symbolic flag, qualifier, unqualified id
" (this is used in both haskell_doc.vim and in GHC.vim)
function! Haskell_GetNameSymbol(line,col,off)
  let name    = "[a-zA-Z0-9_']"
  let symbol  = "[-!#$%&\*\+/<=>\?@\\^|~:.]"
  "let [line]  = getbufline(a:buf,a:lnum)
  let line    = a:line

  " find the beginning of unqualified id or qualified id component 
  let start   = (a:col - 1) + a:off
  if line[start] =~ name
    let pattern = name
  elseif line[start] =~ symbol
    let pattern = symbol
  else
    return []
  endif
  while start > 0 && line[start - 1] =~ pattern
    let start -= 1
  endwhile
  let id    = matchstr(line[start :],pattern.'*')
  " call confirm(id)

  " expand id to left and right, to get full id
  let idPos = id[0] == '.' ? start+2 : start+1
  let posA  = match(line,'\<\(\([A-Z]'.name.'*\.\)\+\)\%'.idPos.'c')
  let start = posA>-1 ? posA+1 : idPos
  let posB  = matchend(line,'\%'.idPos.'c\(\([A-Z]'.name.'*\.\)*\)\('.name.'\+\|'.symbol.'\+\)')
  let end   = posB>-1 ? posB : idPos

  " special case: symbolic ids starting with .
  if id[0]=='.' && posA==-1 
    let start = idPos-1
    let end   = posB==-1 ? start : end
  endif

  " classify full id and split into qualifier and unqualified id
  let fullid   = line[ (start>1 ? start-1 : 0) : (end-1) ]
  let symbolic = fullid[-1:-1] =~ symbol  " might also be incomplete qualified id ending in .
  let qualPos  = matchend(fullid, '\([A-Z]'.name.'*\.\)\+')
  let qualifier = qualPos>-1 ? fullid[ 0 : (qualPos-2) ] : ''
  let unqualId  = qualPos>-1 ? fullid[ qualPos : -1 ] : fullid
  " call confirm(start.'/'.end.'['.symbolic.']:'.qualifier.' '.unqualId)

  return [start,symbolic,qualifier,unqualId]
endfunction

function! Haskell_GatherImports()
  let imports={0:{},1:{}}
  let i=1
  while i<=line('$')
    let res = Haskell_GatherImport(i)
    if !empty(res)
      let [i,import] = res
      let prefixPat = '^import\s*\(qualified\)\?\s\+'
      let modulePat = '\([A-Z][a-zA-Z0-9_''.]\+\)'
      let asPat     = '\(\s\+as\s\+'.modulePat.'\)\?'
      let hidingPat = '\(\s\+hiding\s*\((.*)\)\)\?'
      let listPat   = '\(\s*\((.*)\)\)\?'
      let importPat = prefixPat.modulePat.asPat.hidingPat.listPat.'\s*$'
      let [_,qualified,module,_,as,_,hiding,_,explicit;x] = matchlist(import,importPat)
      let what = as=='' ? module : as
      if qualified=='qualified'
        let imports[1][what] = {'line':i,'hiding':hiding,'explicit':explicit}
      else
        let imports[1][what] = {'line':i,'hiding':hiding,'explicit':explicit}
        let imports[0][what] = {'line':i,'hiding':hiding,'explicit':explicit}
      endif
    endif
    let i+=1
  endwhile
  if !has_key(imports[1],'Prelude') 
    let imports[0]['Prelude'] = {'line':-1}
    let imports[1]['Prelude'] = {'line':-1}
  endif
  return imports
endfunction

" collect lines belonging to a single import statement;
" return number of last line and collected import statement
" (assume opening parenthesis, if any, is on the first line)
function! Haskell_GatherImport(lineno)
  let lineno = a:lineno
  let import = getline(lineno)
  if !(import=~'^import') | return [] | endif
  let open  = strlen(substitute(import,'[^(]','','g'))
  let close = strlen(substitute(import,'[^)]','','g'))
  while open!=close
    let lineno += 1
    let linecont = getline(lineno)
    let open  += strlen(substitute(linecont,'[^(]','','g'))
    let close += strlen(substitute(linecont,'[^)]','','g'))
    let import .= linecont
  endwhile
  return [lineno,import]
endfunction
