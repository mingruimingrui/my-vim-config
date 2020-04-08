syntax on

" Plugins
call plug#begin('~/.vim/plugged')

" File explorer
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Code outline
Plug 'majutsushi/tagbar'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linter
Plug 'dense-analysis/ale'

" Fuzzy file search
Plug 'kien/ctrlp.vim'

" Comment helper
Plug 'tpope/vim-commentary'

" ncm2
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'  " python
Plug 'ncm2/ncm2-go'  " golang

" jedi python toolkit
Plug 'davidhalter/jedi-vim'

" Sort Python imports
Plug 'tweekmonster/impsort.vim'

" Better indenting for python
Plug 'Vimjas/vim-python-pep8-indent'

" Golang
Plug 'fatih/vim-go'

call plug#end()


filetype indent on

set fileformat=unix
set shortmess+=c

set mouse=a  " change cursor per mode
set number  " always show current line number
set smartcase  " better case-sensitivity when searching
set wrapscan  " begin search from top of file when nothing is found anymore

set tabstop=4
set shiftwidth=4
set softtabstop=4
set fillchars+=vert:\  " remove chars from seperators

set relativenumber

set history=1000

set hlsearch
set incsearch

" No backup or swap file
set nobackup
set noswapfile

" Keep three lines between the cursor and the edge of the screen
set scrolloff=3

" Already shown in statusline
set noshowmode
set noshowcmd

" Always show statusline
set laststatus=2

" Error
set noerrorbells
set visualbell
set t_vb=

" Mapping escape
inoremap jk <ESC>
inoremap <C-c> <ESC>
nnoremap <C-z> <Esc>  " disable terminal ctrl-z

" Easy split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tabs
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" Mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction


" nerdtree options
map <C-n> :NERDTreeToggle<CR>

" tagbar options
map <C-t> :set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>

" airline options
let g:airline_powerline_fonts = 1
let g:airline_section_y = ""
let g:airline#extensions#tabline#enabled = 1
" let g:airline_section_error = ""
" let g:airline_section_warning = ""
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" ale options
" let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
" let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
let g:ale_list_window_size = 4
let g:ale_sign_column_always = 0
let g:ale_open_list = 1
" let g:ale_keep_list_window_open = '1'
let g:ale_sign_error = '‼'
let g:ale_sign_warning = '∙'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = '0'
let g:ale_lint_on_enter = '1'
let g:ale_lint_on_save = '1'

" ncm2 options
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert

let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'

set pumheight=5

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

" jedi options
" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0

" Remove all trailing whitespace by pressing C-S
nnoremap <C-S> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
