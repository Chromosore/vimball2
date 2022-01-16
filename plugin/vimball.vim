" vimball2 - A rewrite of the vimball extractor by Dr Chip (www.drchip.org)
" for the vim8 era
"
" Author: Charles E. Campbell
" Maintainer: Raphaël Blanchard <raphi@babinux.com>
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
com!        -complete=dir -nargs=+ -bang  VimballArchive call vimball2#archive(<f-args>, <bang>0)
com!        -complete=dir -nargs=? -bang  VimballExtract call vimball2#extract(bufnr('%'), <bang>0, <f-args>)
com!                      -nargs=?        VimballList    call vimball2#list(bufnr('%'))

" Legacy API
com! -range -complete=dir -nargs=+ -bang  MkVimball      <line1>,<line2>call vimball2#legacy#mk_vimball(<bang>0, <f-args>)
com!        -complete=dir -nargs=?        UseVimball     call vimball2#extract(bufnr('%'), <f-args>)
com!        -complete=dir -nargs=*        RmVimball      call vimball2#legacy#remove(<f-args>)


let &cpo = s:cpo_save
unlet s:cpo_save
" vim: fdm=marker
