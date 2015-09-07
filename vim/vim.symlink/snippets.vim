" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
inoremap <c-x><c-k> <c-x><c-k>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

" Set snippet directory
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippets']
