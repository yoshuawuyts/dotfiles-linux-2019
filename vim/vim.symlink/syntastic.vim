autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : findfile('.jshintrc', '.;') != '' ? ['jshint'] : ['standard']
let g:syntastic_css_checkers = ['recess']

