" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details


fun! vimball2#legacy#remove(file, ...)
	if a:0 == 1
		let l:path = a:1
	elseif a:0 == 0
		let l:path = vimball2#util#home()
	else
		throw 'vimball2: too many arguments for function: vimball2#legacy#remove'
	endif

	let l:directory = path .. '/pack/vimball/start/' .. fnamemodify(a:file, ':t:r')
	if isdirectory(directory)
		call vimball2#util#prompt_rm(directory)
	else
		echohl ErrorMsg
		echomsg "vimball2: this vimball isn't installed"
		echohl None
	endif
endfun


fun! vimball2#legacy#mk_vimball(overwrite, filename, ...) range abort
	if a:0 == 1
		let l:root = fnamemodify(a:1, ':p')
	elseif a:0 == 0
		let l:root = fnamemodify('.', ':p')
	else
		throw 'vimball2: too many arguments for function: vimball2#legacy#mk_vimball'
	endif

	if filereadable(a:filename)
		if a:overwrite
			call delete(a:filename)
		elseif &confirm
			call vimball2#util#prompt_rm(a:filename)
		else
			throw 'vimball2: file exists (add ! to override)'
		end
	endif


	call writefile(g:vimball2#archiver#archive_header, a:filename)

	for l:node in getline(a:firstline, a:lastline)
		if isdirectory(root .. node)
			echohl WarningMsg
			echomsg printf('Only files must be specified. Skipping directory %s', node)
			echohl None
			continue
		endif

		call vimball2#archiver#archive_file(root, root .. node, a:filename)
	endfor
endfun
