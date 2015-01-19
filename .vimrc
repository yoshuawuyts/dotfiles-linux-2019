# make backspaces behave normally
# in edit mode
set backspace=2

set number

# enable pathogen package manager
execute pathogen#infect()

# enable syntax highlighting
syntax on

# enable indenting based on filetype
filetype plugin indent on

# nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
