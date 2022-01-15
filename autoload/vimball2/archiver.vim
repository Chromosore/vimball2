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
	let l:dir_files = readdir(a:directory)
	call writefile(s:header, a:dest_file)
	call s:archive_recursive_1('', a:directory, dir_files, a:dest_file)
endfun


fun! s:archive_recursive(prefix, directory, dest_file)
	return s:archive_recursive_1(a:prefix, a:directory, readdir(a:directory), a:dest_file)
endfun

fun! s:archive_recursive_1(prefix, directory, filelist, dest_file)
	for l:node in a:filelist
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
