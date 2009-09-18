syn keyword mooseStatement extends with requires has before after around augment contained
syn keyword mooseStatement subtype coerce contained

syn keyword mooseStatementOption is isa does coerce trigger required lazy weak_ref auto_deref lazy_build init_arg default builder clearer reader writer handles predicate contained
syn keyword mooseStatementOption as where contained
syn keyword mooseStatementOption from via contained

syn region mooseBlock start='use\s\+\(Any::\|\)Mo[ou]se' end='no\s\+\(Any::\|\)Mo[ou]se' contains=@perlTop,mooseStatement,mooseStatementOption keepend

hi def link mooseStatement Statement
hi def link mooseStatementOption Identifier
