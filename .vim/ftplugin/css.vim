function! CssFoldMethod(lnum)
	let l:line = getline(a:lnum)
	if l:line =~ '{$'
		return '>1'
	elseif l:line =~ '}$'
		return '<1'
	else
		return '='
	endif
endfunction

setl foldmethod=expr
setl foldexpr=CssFoldMethod(v:lnum)
setl foldlevel=0
