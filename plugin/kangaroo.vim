function! s:push()
	if !exists('w:positions')
		let w:positions = []
	endif
	let pos = [bufnr("%"), winsaveview()]
	if len(w:positions) == 0 || w:positions[-1] != pos
		call add(w:positions, pos)
	endif
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
	call winrestview(pos)
endfunction

function! kangaroo#altitude()
	if !exists('w:positions')
		return 0
	endif
	return len(w:positions)
endfunction

command! KangarooPush call s:push()
command! KangarooPop call s:pop()

noremap <silent> <Plug>KangarooPush :<C-U>KangarooPush<CR>
noremap <silent> <Plug>KangarooPop :<C-U>KangarooPop<CR>

if !exists("g:kangaroo_no_mappings") || !g:kangaroo_no_mappings
	nmap <silent> zp <Plug>KangarooPush
	nmap <silent> zP <Plug>KangarooPop
endif
