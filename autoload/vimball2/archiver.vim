" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details
" Last Change: 2021 jan. 14


let s:header = [
			\ '" Vimball Archiver',
			\ 'UseVimball',
			\ 'finish'
\]


fun! vimball2#archiver#archive(directory, dest_file)
	call writefile(s:header, a:dest_file)
	call s:archive_recursive('', a:directory, a:dest_file)
endfun


fun! s:archive_recursive(prefix, directory, dest_file)
	for l:node in readdir(a:directory)
		let l:absnode = a:directory .. '/' .. node
		let l:relnode = a:prefix .. node

		if isdirectory(absnode)
			call s:archive_recursive(relnode .. '/', absnode, a:dest_file)
		else
			let l:content = readfile(absnode)
			call writefile([relnode .. "\t[[[1", len(content)], a:dest_file, 'a')
			call writefile(content, a:dest_file, 'a')
		endif
	endfor
endfun
