if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn region svkRegion    start="^===.*===$" end="\%$" contains=ALL
syn match svkRemoved    "^D    .*$" contained
syn match svkAdded      "^A[ M]   .*$" contained
syn match svkModified   "^M[ M]   .*$" contained
syn match svkProperty   "^_M   .*$" contained

syn sync clear
syn sync match svkSync  grouphere svkRegion "^===.*===$"me=s-1

if version >= 508 || !exists("did_svk_syn_inits")
  if version <= 508
    let did_svk_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink svkRegion      Comment
  HiLink svkRemoved     Constant
  HiLink svkAdded       Identifier
  HiLink svkModified    Special
  HiLink svkProperty    Special

  delcommand HiLink
endif

let b:current_syntax = "svk"

