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

function! MaxTabCount()
	let _max = 0

	for l in getline(0, "$")
		let tab_count = len(split(l, '\t')) - 1
		if tab_count > _max
			let _max = tab_count
		endif
	endfor

	return _max
endfunction

function! CalcTS()
	let _max = 0
	let tab_count = MaxTabCount()
	echom tab_count

	for l in getline(0, "$")
		let i = 0

		for item in split(l, '\t')[:-2]
			if i < tab_count
				if len(item) > _max
					let _max = len(item)
				endif

				let i += 1
			endif
		endfor
	endfor

	return _max + 1
endfunction

function! FETS()
	let fets = CalcTS()

	if fets == &l:tabstop
		let &l:tabstop = 2
		let &l:softtabstop = 2
		let &l:shiftwidth = 2
	else
		let &l:tabstop = fets
		let &l:softtabstop = fets
		let &l:shiftwidth = fets
	endif
endfunction

map <c-t> :call FETS()<cr>
