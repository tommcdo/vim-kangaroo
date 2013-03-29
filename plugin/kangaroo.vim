let s:positions = []

function! s:push()
	call add(s:positions, [bufnr("%"), getpos(".")])
	echo bufnr("%")
endfunction

function! s:pop()
	let idx = len(s:positions) - 1
	if idx < 0
		echohl ErrorMsg | echo "jump stack empty" | echohl None
	else
		let [bufnr, pos] = s:positions[idx]
		if idx == 0
			let s:positions = []
		else
			let s:positions = s:positions[0:(idx - 1)]
		endif
		if bufnr != bufnr("%")
			execute "edit #" . bufnr
		endif
		call setpos(".", pos)
	endif
endfunction

noremap <silent> <Plug>KangarooPush :call <SID>push()<CR>
noremap <silent> <Plug>KangarooPop :call <SID>pop()<CR>

if !exists("g:kangaroo_no_mappings") || !g:kangaroo_no_mappings
	nmap <silent> zp <Plug>KangarooPush
	nmap <silent> zP <Plug>KangarooPop
endif
