""
" Fake elastic tabstops
" =====================
"
" I really like the idea of elastic tabstops[1].  Unfortunately, it is not
" possible to implement them in any traditional text editor because
"
" -   All tabstops have the same distance to each other
" -   All lines have the same tabstops
"
" To still get the minimal functionality, this plugin simply uses the maximum
" value for the tabstops.  This of course leaves you with huge tabstops, but
" at least you get proper alignment.  It might be useful in some specific
" contexts, e.g. tab separated value files.
"
" Usage
" -----
"
" Press <c-t> to set tabstop width. Press again to reset.
"
" License
" -------
"
" GPL3+
"
"
" [1]: http://nickgravgaard.com/elastic-tabstops/

function! s:CalcTS()
	let l:tabs = [0]

	for l:line in getline(0, "$")
		let l:i = 0

		for l:item in split(l:line, '\t')[:-2]
			let l:len = len(l:item) + 1

			if len(l:tabs) <= l:i
				call add(l:tabs, l:len)
			elseif l:len > l:tabs[l:i]
				let l:tabs[l:i] = l:len
			endif

			let l:i += 1
		endfor
	endfor

	return l:tabs
endfunction

function! FETS()
	if get(b:, 'fets_active', 0)
		let &l:tabstop = &g:tabstop
		let &l:shiftwidth = &g:shiftwidth
		let &l:softtabstop = &g:softtabstop
		let b:fets_active = 0
	else
		let l:fets = max(s:CalcTS())
		let &l:tabstop = l:fets
		let &l:shiftwidth = l:fets
		let &l:softtabstop = -1
		let b:fets_active = 1
	endif
endfunction

noremap <c-t> :call FETS()<CR>
