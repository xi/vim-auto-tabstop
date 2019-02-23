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
" value for the tabstops.  This of course leaves you with hue tabstops, but
" at least you get proper alignment.  It might be useful in some specific
" contexts, e.g. tab separated value files.
"
" Usage
" -----
"
" Press <c-t> to set tabstop width. Press again to reset to 2.
"
" License
" -------
"
" GPL3+
"
"
" [1]: http://nickgravgaard.com/elastic-tabstops/

function! s:MaxTabCount()
	let l:max = 0

	for l:line in getline(0, "$")
		let l:tab_count = len(split(l:line, '\t')) - 1
		if l:tab_count > l:max
			let l:max = l:tab_count
		endif
	endfor

	return l:max
endfunction

function! s:CalcTS()
	let l:max = 0
	let l:tab_count = s:MaxTabCount()

	for l:line in getline(0, "$")
		let l:i = 0

		for l:item in split(l:line, '\t')[:-2]
			if l:i < l:tab_count
				if len(l:item) > l:max
					let l:max = len(l:item)
				endif

				let l:i += 1
			endif
		endfor
	endfor

	return l:max + 1
endfunction

function! FETS()
	let l:fets = s:CalcTS()

	if l:fets == &l:tabstop
		let &l:tabstop = 2
		let &l:softtabstop = 2
		let &l:shiftwidth = 2
	else
		let &l:tabstop = l:fets
		let &l:softtabstop = l:fets
		let &l:shiftwidth = l:fets
	endif
endfunction

map <c-t> :call FETS()<CR>
