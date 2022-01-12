" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details
" Last Change: 2021 jan. 12


fun! vimball2#extractor#extract(bufnr, dest_dir) abort
	try
		let l:iter = vimball2#extractor#iter_archive(a:bufnr)
	catch /^vimball2: not a vimball$/
		echoerr "(Vimball2) The current file does not appear to be a Vimball!"
		return
	endtry

	let l:entry = iter.next()
	while l:entry isnot v:null
		let l:content = getbufline(a:bufnr, entry.file.start_line, entry.file.end_line)

		let l:filedir = a:dest_dir .. '/' .. fnamemodify(entry.file.path, ':h')
		if !isdirectory(filedir)
			call mkdir(filedir, 'p')
		endif

		call writefile(content, a:dest_dir .. '/' .. entry.file.path)

		let l:entry = iter.next()
	endwhile
endfun


fun! vimball2#extractor#iter_archive(bufnr)
	if getbufline(a:bufnr, 1)[0] !~ '^" Vimball Archiver'
		throw "vimball2: not a vimball"
	endif

	let l:iter = {}
	let l:iter.buffer = a:bufnr
	let l:iter.lineno = 4
	let l:iter.next   = function('s:archive_iter_next', [iter])

	return iter
endfun


fun! s:archive_iter_next(state)
	try
		let [l:header, l:size] = getbufline(a:state.buffer, a:state.lineno, a:state.lineno + 1)
	catch /^Vim\%((\a\+)\)\=:E688/
		return v:null
	endtry

	let l:size = str2nr(size)
	let l:filepath     = substitute(header,   '\V\t[[[1\$', '',  '')
	let l:filepath     = substitute(filepath, '\\',         '/', 'g')
	let l:fileencoding = matchstr(header, '\v^\d+\s*\zs\S{-}\ze$')

	let l:entry = {}
	let l:entry.file = {}

	let l:entry.lineno = a:state.lineno

	let l:entry.file.path = filepath
	let l:entry.file.size = size
	let l:entry.file.encoding = fileencoding
	let l:entry.file.start_line = a:state.lineno + 2
	let l:entry.file.end_line   = a:state.lineno + 2 + size - 1
	" don't include the next entry in the file's body

	let a:state.lineno += 2 + size
	return l:entry
endfun
