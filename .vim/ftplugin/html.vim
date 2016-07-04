function! HtmlFoldMethod(lnum)
	let l:line = getline(a:lnum)
	for l:tag in ['!', 'br', 'img', 'hr', 'meta', 'input', 'embed', 'area', 'base', 'col', 'keygen', 'link', 'param', 'source']
		if l:line =~ printf('^\s*<%s[^/>]*>$', l:tag)
			return '='
		endif
	endfor
	if l:line =~ '^\s*<[^/>]*>$'
		return 'a1'
	elseif l:line =~ '^\s*</[^/>]*>$'
		return 's1'
	else
		return '='
	endif
endfunction

setl foldmethod=expr
setl foldexpr=HtmlFoldMethod(v:lnum)
setl foldlevel=1
