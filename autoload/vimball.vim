" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details
" Last Change: 2021 jan. 12


fun! vimball#archive(directory, filename, ...)
	if a:0 == 1
		let l:overwrite = a:0
	elseif a:0 == 0
		let l:overwrite = 0
	else
		throw 'vimball: too many arguments for function: vimball#archive'
	end

	if filereadable(a:filename)
		if overwrite
			call delete(a:filename)
		elseif &confirm
			call vimball#util#prompt_rm(a:filename)
		else
			throw 'vimball: file exists (add ! to override)'
		end
	endif

	call vimball#archiver#archive(a:directory, a:filename)
endfun


fun! vimball#extract(bufnr, ...)
	if a:0 == 2
		let l:overwrite = a:1
		let l:dest_dir = a:2
	elseif a:0 == 0 || a:0 == 1
		if a:0 == 1
			let l:overwrite = a:1
		else
			let l:overwrite = 0
		endif

		let l:home = vimball#util#home()
		let l:dest_dir = home .. '/pack/vimball/start/' .. fnamemodify(bufname(a:bufnr), ':t:r')
	else
		throw 'vimball: too many arguments for function: vimball#extract'
	endif

	if isdirectory(dest_dir)
		if overwrite
			call delete(dest_dir, 'rf')
		elseif &confirm
			call vimball#util#prompt_rm(dest_dir)
		else
			throw 'vimball: file exists (add ! to override)'
		end
	endif

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
