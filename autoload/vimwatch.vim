augroup vim-watch

fun! vimwatch#enable()
	let l:var = '$XDG_RUNTIME_DIR'
	if(!exists(l:var))
		echoe "vimwatch error: " . l:var . " not set"
		return
	else
		let s:prefix=expand(l:var)."/vim-watch"
		if (!isdirectory(s:prefix))
			call mkdir(s:prefix)
		endif
		augroup vim-watch
		autocmd vim-watch BufWritePost * call writefile([], s:prefix."/save")
	endif
endfun

fun! vimwatch#disable()
	autocmd! vim-watch
endfun

call vimwatch#disable()
