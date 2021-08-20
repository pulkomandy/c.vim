" Delete the keyword-based cType matching, it just gets in the way
syn clear cppType

" Redefine cppStatement so that "new" is not a keyword, so the below can match
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

" Match various well known things from the STL that are known to contain types
" in their template arguments
syn match cJCCppCast "\(static_cast\|dynamic_cast\|reinterpret_cast\|const_cast\|time_point_cast\|make_unique\|make_shared\|make_optional\)<\zs\I[[:ident:]:&*]*>"me=e-1

" Redefine several things from the C syntax to handle templates and references
" in addition to the other things
syn clear cJCTypeInDecl
syn clear cJCDecl
syn clear cJCFunc
syn clear cJCParamType

syn match	cJCTypeInDecl	"^\s*\(\(inline\|const\|restrict\|extern\|GLOBAL\|static\|register\|auto\|volatile\|virtual\|signed\|unsigned\|struct\)[ \t*]\+\)*\I[[:ident:]:<>]*&\?\([ \t*]\+\(const\|restrict\|volatile\)\)*[ \t*]*" contained
syn match	cJCDecl		"^\s*\(inline\s\+\)\=\(\I[[:ident:]:<>]*&\?[ \t*]\+\)\+\s*\I" contains=cJCTypeInDecl

syn region	cJCFunc		start="^\t*\(\(inline\|const\|extern\|GLOBAL\|static\|register\|auto\|volatile\|virtual\|signed\|unsigned\|struct\)[ \t*]\+\)*\I[[:ident:]:<>]*\s\+\**\s*\I[[:ident:]:]*\s*(" end=")" contains=CJCParamVoid,cJCParamType,cJCTypeInDecl,cComment

" This matches constructors, but only if they are in the first column for now
" (no identation). Otherwise it also matches all function calls, and that
" breaks a lot of things.
syn region	cJCFunc		start="^\I[[:ident:]:<>]*\s*(" end=")" contains=CJCParamVoid,cJCParamType

syn match	cJCParamType	"\<\(\(const\|restrict\|volatile\|signed\|unsigned\|struct\|enum\)[ \t*]\+\)*\I[[:ident:]:<>]*&\?[ \t*]\+\I"he=e-1 contained containedin=cJCFor

hi link cJCNew		cType

hi link cJCCppCast cType
hi link cJCTypeInDecl cType
hi link cJCParamType cType

" Uncomment these for debug mode: very visible highlight of what we match
"hi cJCCppCast		guibg=#00FF80
"hi cJCFunc		guibg=#00FF00
