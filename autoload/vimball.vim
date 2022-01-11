" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details
" Last Change: 2021 jan. 11


fun! vimball#archive(directory, filename, overwrite)
	if filereadable(a:filename)
		if a:overwrite
			call delete(a:filename)
		elseif &confirm
			call vimball#util#prompt_rm(a:filename)
		else
			return 1
		end
	endif

	call vimball#archiver#archive(a:directory, a:filename)
endfun


fun! vimball#extract(bufnr, ...)
	if a:0 == 1
		let l:home = a:1
	elseif a:0 == 0
		let l:home = vimball#util#home()
	else
		throw 'Vim(call):E118: Too many arguments for function: vimball#extract'
	endif

	let l:dest_dir = home .. '/pack/vimball/' .. fnamemodify(bufname(a:bufnr), ':t:r')

	call vimball#extractor#extract(a:bufnr, dest_dir)
endfun


fun! vimball#list(bufnr)
	let l:iter = vimball#extractor#iter_archive(a:bufnr)

	let l:entry = iter.next()
	while l:entry != v:null
		echo entry.filename
		let l:entry = iter.next()
	endwhile
endfun
