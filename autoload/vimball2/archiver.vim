" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details


let vimball2#archiver#archive_header = [
			\ '" Vimball Archiver',
			\ 'UseVimball',
			\ 'finish'
\]


fun! vimball2#archiver#archive(directory, output_file) abort
	call writefile(g:vimball2#archiver#archive_header, a:output_file)
	call s:archive_recursive(
				\ fnamemodify(a:directory, ':p'),
				\ fnamemodify(a:directory, ':p'),
				\ fnamemodify(a:output_file, ':p'))
endfun


fun! s:archive_recursive(root, directory, output_file) abort
	for l:node in readdir(a:directory)
		let l:absnode = fnamemodify(a:directory .. node, ':p')
		if absnode ==# a:output_file
			continue
		endif

		if isdirectory(absnode)
			call s:archive_recursive(a:root, absnode, a:output_file)
		else
			call vimball2#archiver#archive_file(a:root, absnode, a:output_file)
		endif
	endfor
endfun


fun! vimball2#archiver#archive_file(root, filename, output_file) abort
	let l:relfile = substitute(
				\ fnamemodify(a:filename, ':p'),
				\ '^' .. fnameescape(fnamemodify(a:root, ':p')),
				\ '', '')

	let l:content = readfile(a:filename)
	call writefile([relfile .. "\t[".."[[1", len(content)], a:output_file, 'a')
	call writefile(content, a:output_file, 'a')
endfun
