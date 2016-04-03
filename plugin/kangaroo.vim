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
	let [bufnr, pos] = remove(w:positions, -1)
	if bufnr != bufnr("%")
		execute "edit #" . bufnr
	endif
	call setpos(".", pos)
endfunction

command! KangarooPush call s:push()
command! KangarooPop call s:pop()

noremap <silent> <Plug>KangarooPush :<C-U>KangarooPush<CR>
noremap <silent> <Plug>KangarooPop :<C-U>KangarooPop<CR>

if !exists("g:kangaroo_no_mappings") || !g:kangaroo_no_mappings
	nmap <silent> zp <Plug>KangarooPush
	nmap <silent> zP <Plug>KangarooPop
endif
