" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details
" Last Change: 2021 jan. 12

fun! vimball2#util#msg(message)
	echo a:message
endfun

fun! vimball2#util#home()
	return matchstr(&rtp, '\v^[^,]+')
endfun
