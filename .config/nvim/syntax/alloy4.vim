
" Vim syntax file
" Language: Alloy4
" Maintainer:   Derek Rayside <drayside@mit.edu>
" Last Change:  2007-August-27
" Derived from alloy3.vim, by Emil Sit <sit@mit.edu>, 2005
" Derived from alloy2.vim, by Brant Hashii <bhashii@acm.org>, 2002
"
" Put this file in your ~/.vim/syntax directory and add the following 
" line to your ~/.vimrc
" au BufRead,BufNewFile *.als setfiletype alloy4



" Remove any old syntax stuff hanging around
syn clear

set textwidth=70    "allows autowrap of text

" A bunch of useful keywords
syn keyword aModule module open uses
syn keyword aSig        abstract static sig extends
syn keyword aQualifier  part disj disjoint exh
syn keyword aSchema     pred fact assert det fun facts constraints
syn keyword aCommand    run check
syn keyword aScope      eval using for but int without
syn keyword aSetMult    set option scalar
syn keyword aExpression this result with let none univ iden if then else Int sum
syn keyword aOp         implies else not iff and or in
syn keyword aQuantifier all no lone one some

syn keyword aTodo       contained TODO FIXME NOTE XXX

" cCommentGroup allows adding matches for special things in comments
syn cluster aCommentGroup   contains=cTodo

syntax region aCommentL start="--" end="$" keepend contains=@aCommentGroup
syntax region aCommentL start="//" skip="\\$" end="$" keepend contains=@aCommentGroup
syntax region aComment  start="/\*" end="\*/" contains=@aCommentGroup

hi link aCommentL aComment

if !exists("did_alloy4_syntax_inits")
  let did_alloy4_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link aComment      Comment
  hi link aModule       Include
  hi link aSig          Structure
  hi link aQualifier    Label
  hi link aSchema       Structure
  hi link aCommand      Structure
  hi link aScope        Repeat
  hi link aSetMult      Label
  hi link aExpression   Statement
  hi link aOp           Operator
  hi link aQuantifier   Statement
  hi link aTodo         Todo
endif

let b:current_syntax = "alloy4"


