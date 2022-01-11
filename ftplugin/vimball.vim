" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" See plugin/vimball.vim or |vimball2| for more details
" Last Change: 2021 jan. 11

setlocal buftype=nofile fmr=[[[,]]] fdm=marker

if &fileformat != 'unix'
	setlocal ma fileformat=unix noma
endif

if line('$') > 1
	call vimball#util#msg("Source this file to extract it! (:so %)")
endif
