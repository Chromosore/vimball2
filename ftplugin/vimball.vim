" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details

setlocal buftype=nofile fmr=[[[,]]] fdm=marker nomodeline

if &fileformat != 'unix'
	setlocal ma fileformat=unix noma
endif

if line('$') > 1
	call vimball2#util#msg("Source this file to extract it! (:so %)")
endif
