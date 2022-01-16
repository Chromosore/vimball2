" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details

fun! vimball2#util#msg(message)
	echo a:message
endfun

fun! vimball2#util#home()
	return matchstr(&rtp, '\v^[^,]+')
endfun

fun! vimball2#util#prompt_rm(file)
	let l:choice = confirm(
				\ printf('Delete %s?', a:file),
				\ join(['&Yes', '&No'], "\n"))

	if choice == 1
		call delete(a:file, 'rf')
		return 1
	endif

	return 0
endfun
