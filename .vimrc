call plug#begin('~/.vim/plugged')
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'myusuf3/numbers.vim'
Plug 'junegunn/fzf.vim'
Plug 'cespare/vim-toml'


" Initialize plugin system
call plug#end()


set nocompatible              " be iMproved, required                                                                                                                                                                                          
filetype off                  " required
if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
else
    set termguicolors
endif
""let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
""let ayucolor="dark"   " for dark version of theme

syntax on
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set mouse-=a
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
nnoremap <F6> :NumbersToggle<CR>


let g:terraform_align=1

se nu
se hidden
" fix vim inside tmux/byobu
set background=dark
