function! MySave()
	let l:path = expand('%:p')
	let l:path = substitute(l:path, '\\', '\/', 'g')
	let l:cache_dir = g:my_save_cache_dir
	let l:bak_dir = g:my_save_bak_dir
	if match(l:path, l:cache_dir) == 0
		let l:path = substitute(l:path, l:cache_dir, l:bak_dir, '')
		let l:dir = fnamemodify(l:path, ':h')
		if !isdirectory(l:dir)
			call mkdir(l:dir, 'p')
		endif
		execute 'w! '.l:path
	endif
endfunction

" vim: ts=4 sw=4 sts=0 noet
