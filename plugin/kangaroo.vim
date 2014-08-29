function! s:push()
	if !exists('w:positions')
		let w:positions = []
	endif
	call add(w:positions, [bufnr("%"), getpos(".")])
endfunction

function! s:pop()
	if !exists('w:positions') || len(w:positions) == 0
		echohl ErrorMsg | echo "jump stack empty" | echohl None
		return
	endif
	let idx = len(w:positions) - 1
	let [bufnr, pos] = w:positions[idx]
	if idx == 0
		let w:positions = []
	else
		let w:positions = w:positions[0:(idx - 1)]
	endif
	if bufnr != bufnr("%")
		execute "edit #" . bufnr
	endif
	call setpos(".", pos)
endfunction

command! KangarooPush call s:push()
command! KangarooPop call s:pop()

noremap <silent> <Plug>KangarooPush :<C-U>KangarooPush<CR>
noremap <silent> <Plug>KangarooPop :<C-I>KangarooPop<CR>

if !exists("g:kangaroo_no_mappings") || !g:kangaroo_no_mappings
	nmap <silent> zp <Plug>KangarooPush
	nmap <silent> zP <Plug>KangarooPop
endif
