let s:positions = {}

function! s:push()
	let tab = tabpagenr()
	let win = winnr()
	if !has_key(s:positions, tab)
		let s:positions[tab] = {}
	endif
	if !has_key(s:positions[tab], win)
		let s:positions[tab][win] = []
	endif
	call add(s:positions[tab][win], [bufnr("%"), getpos(".")])
	echo bufnr("%")
endfunction

function! s:pop()
	let tab = tabpagenr()
	let win = winnr()
	if !has_key(s:positions, tab) || !has_key(s:positions[tab], win) || len(s:positions[tab][win]) == 0
		echohl ErrorMsg | echo "jump stack empty" | echohl None
		return
	endif
	let idx = len(s:positions[tab][win]) - 1
	let [bufnr, pos] = s:positions[tab][win][idx]
	if idx == 0
		let s:positions[tab][win] = []
	else
		let s:positions[tab][win] = s:positions[tab][win][0:(idx - 1)]
	endif
	if bufnr != bufnr("%")
		execute "edit #" . bufnr
	endif
	call setpos(".", pos)
endfunction

noremap <silent> <Plug>KangarooPush :call <SID>push()<CR>
noremap <silent> <Plug>KangarooPop :call <SID>pop()<CR>

if !exists("g:kangaroo_no_mappings") || !g:kangaroo_no_mappings
	nmap <silent> zp <Plug>KangarooPush
	nmap <silent> zP <Plug>KangarooPop
endif
