" Delete the keyword-based cType matching, it just gets in the way
syn clear cppType

" Redefine pccStatement so that "new" is not a keyword, so the below can match
" it
syn clear cppStatement

syn keyword	cJCNewStatement	new contained
hi def link cJCNewStatement cppStatement

syn keyword cppStatement	delete this friend using
if !exists("cpp_no_cpp20")
  syn keyword cppStatement	co_await co_return co_yield requires
endif

" Detect type in "new" expressions
syn match cJCNew "new \I[[:ident:]:]*"  contains=cJCNewStatement

hi link cJCNew		cType

