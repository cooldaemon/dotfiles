" Vim syntax file
" Language: blockdiag
" Filenames: .diag

" Quit when a (custom) syntax file was already loaded
if exists ("b:current_syntax")
    finish
endif

syn match diagComment "//.*$"

syn keyword diagKeyword label return failed color
syn keyword diagKeyword diagonal note rightnote leftnote

syn region diagString start=+"+ skip=+\\.+ end=+"+

syn match diagOperator "->"
syn match diagOperator "-->"
syn match diagOperator "--->"
syn match diagOperator "<-"
syn match diagOperator "<--"
syn match diagOperator "<---"

" syn region diagFunction start=+===+ skip=+\\.+ end=+===+
" syn region diagFunction start=+...+ skip=+\\.+ end=+...+

syn keyword diagConfig edge_length span_height fontsize
syn keyword diagConfig activation autonumber default_note_color

hi def link diagComment Comment
hi def link diagKeyword Keyword
hi def link diagOperator Operator
hi def link diagString String
hi def link diagFunction Function
hi def link diagConfig Special

let b:current_syntax = "diag"
