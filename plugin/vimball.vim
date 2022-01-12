" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" Author: Charles E. Campbell
" Maintainer: Raphaël Blanchard <raphi@babinux.com>
" Last Change: 2021 jan. 11
"
" Copyright: (c) 2021-2022 by Raphaël Blanchard
"            (c) 2004-2014 by Charles E. Campbell
"            The VIM LICENSE applies to Vimball.vim, and Vimball.txt
"            (see |copyright|) except use "Vimball" instead of "Vim".
"            No warranty, express or implied.
"  *** ***   Use At-Your-Own-Risk!   *** ***

if &compatible || exists('g:loaded_vimball2')
	finish
endif

let g:loaded_vimball2 = 1
let s:cpo_save = &cpo
set cpo&vim


" Public API
com!        -complete=dir -nargs=+ -bang  VimballArchive call vimball#archive(<f-args>, <bang>0)
com!        -complete=dir -nargs=?        VimballExtract call vimball#extract(bufnr('%'), <f-args>)
com!                      -nargs=?        VimballList    call vimball#list(bufnr('%'))

" Legacy API
com! -range -complete=dir -nargs=+ -bang  MkVimball      call vimball#legacy#mk_vimball(<line1>, <line2>, <bang>0, <f-args>)
com!        -complete=dir -nargs=?        UseVimball     call vimball#extract(bufnr('%'), <f-args>)
com!        -complete=dir -nargs=*        RmVimball      call vimball#legacy#remove(<f-args>)

augroup Vimball
	au!
	au SourceCmd *.vba.gz,*.vba.bz2,*.vba.zip,*.vba.xz			let s:origfile=expand("%")|if expand("%")!=expand("<afile>") | exe "1sp" fnameescape(expand("<afile>"))|endif|call vimball#Decompress(expand("<amatch>"))|so %|if s:origfile!=expand("<afile>")|close|endif
	au SourceCmd *.vba											if expand("%")!=expand("<afile>") | exe "1sp" fnameescape(expand("<afile>"))|call vimball#Vimball(1)|close|else|call vimball#Vimball(1)|endif
	au SourceCmd *.vmb.gz,*.vmb.bz2,*.vmb.zip,*.vmb.xz			let s:origfile=expand("%")|if expand("%")!=expand("<afile>") | exe "1sp" fnameescape(expand("<afile>"))|endif|call vimball#Decompress(expand("<amatch>"))|so %|if s:origfile!=expand("<afile>")|close|endif
	au SourceCmd *.vmb											if expand("%")!=expand("<afile>") | exe "1sp" fnameescape(expand("<afile>"))|call vimball#Vimball(1)|close|else|call vimball#Vimball(1)|endif
augroup END


let &cpo = s:cpo_save
unlet s:cpo_save
" vim: fdm=marker
