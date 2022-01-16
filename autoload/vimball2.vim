" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details


fun! vimball2#archive(directory, filename, ...)
	if a:0 == 1
		let l:overwrite = a:1
	elseif a:0 == 0
		let l:overwrite = 0
	else
		throw 'vimball2: too many arguments for function: vimball2#archive'
	end

	if filereadable(a:filename)
		if overwrite
			call delete(a:filename)
		elseif &confirm
			if vimball2#util#prompt_rm(a:filename) == 0
				return
			endif
		else
			throw 'vimball2: file exists (add ! to override)'
		end
	endif

	call vimball2#archiver#archive(a:directory, a:filename)
endfun


" Function: vimball2#extract
" Parameters:
" 	bufnr: the buffer from which the archive is read
" 	overwrite?: if true, the dest_dir is overwritten
" 	destdir?: if specified, the directory in wich the archive is extracted
fun! vimball2#extract(bufnr, ...)
	if a:0 == 2
		let l:overwrite = a:1
		let l:dest_dir = a:2
	elseif a:0 == 0 || a:0 == 1
		if a:0 == 1
			let l:overwrite = a:1
		else
			let l:overwrite = 0
		endif

		let l:home = vimball2#util#home()
		let l:dest_dir = home .. '/pack/vimball/start/' .. fnamemodify(bufname(a:bufnr), ':t:r')
	else
		throw 'vimball2: too many arguments for function: vimball2#extract'
	endif

	if isdirectory(dest_dir)
		if overwrite
			call delete(dest_dir, 'rf')
		elseif &confirm
			if vimball2#util#prompt_rm(dest_dir) == 0
				return
			endif
		else
			throw 'vimball2: file exists (add ! to override)'
		end
	endif

	call vimball2#extractor#extract(a:bufnr, dest_dir)
	echo "Files have been extracted to " .. fnamemodify(dest_dir, ':~:.')
endfun


fun! vimball2#list(bufnr)
	echohl Title | echo "Vimball Archive Listing" | echohl None

	let l:iter = vimball2#extractor#iter_archive(a:bufnr)

	let l:entry = iter.next()
	while l:entry isnot v:null
		echo printf('%s: %d lines', entry.file.path, entry.file.size)
		let l:entry = iter.next()
	endwhile
endfun
