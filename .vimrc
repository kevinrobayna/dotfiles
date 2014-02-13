" .vimrc 
" Original by Kevin Robayna - http://kevinrobayna.eu http://alanct.com/


" """"""""""""""""""""""""""""""""""""""""""""""""
" =============== General Settings ===============

" Title
set title
set titleold="Terminal"
set titlestring=%F

" Set Number & Print Line
set number

if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" See whitespaces
set list
set listchars=tab:\ \ ,trail:.

" Show Curse Line
set cursorline

" Automatically expand tabs into spaces
set expandtab

" Tabs are four spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Use expected backspace behavior
set backspace=indent,eol,start

" Turn off search highlighting
set nohls

" Turn of swap files and backups
set nobackup
set noswapfile
set nowritebackup

" Turn of text wrapping
set nowrap

" Display position coordinates in bottom right
set ruler

" Abbreviate messages and disable intro screen
set shortmess=atI

" Get rid of omnicomplete doc preview
set completeopt=menu

" Use filetype-specific plugins and indentation
set nosmartindent
filetype plugin indent on

" Turn off automatic line breaking in html and css
au BufRead,BufNewFile *.html,*.css set textwidth=0

" Ignore compiled python
set wildignore+=*.pyc


" """"""""""""""""""""""""""""""""""""""""""""""""
" ============= Custom Key Bindings ==============

" Sets leader to "," and localleader to "\"
let mapleader=","
let maplocalleader="\\"

" Remap new tab
nmap <Leader>t <Esc>:tabnew<CR>

" Remap movement between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Remap window rearrangement
nmap <C-m>h <C-w>H
nmap <C-m>j <C-w>J
nmap <C-m>k <C-w>K
nmap <C-m>l <C-w>L

" Expand into multiple lines and focus the center line
imap <C-E> <Esc>a<Enter><Esc>O

" Toggle paste keybinding
noremap <C-Tab> :<C-U>:tabnext<CR>
set pastetoggle=<Leader>p

" Ctrl-P rebinding
map <Leader>f :CtrlP<CR>

" map :W to :w
command WQ wq
command Wq wq
command W w
command Q q

" Open NERDTree with Ctrl-s
map <silent> <C-s> :NERDTree<CR><C-w>l:NERDTreeFind<CR>

" CTRL-Tab is next tab
map <silent> <C-Tab> :tabNext<CR>

" CTRL-SHIFT-Tab is previous tab
map <silent> <C-S-Tab> :tabPrevious<CR>

" """"""""""""""""""""""""""""""""""""""""""""""""
" =============== Plugin Settings ================

" Use pathogen for plugins
execute pathogen#infect()

" NerdTree support
" ----------------
let NERDTreeShowHidden=1

" open a NERDTree when vim starts up
autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&  b:NERDTreeType == "primary") | q | endif

" CTRLP support
let g:ctrlp_map = '<Leader>o'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:top,min:1,max:20'
nnoremap <leader><tab> :CtrlPMRU<CR>

" Airline
if has("gui_running")
    let g:airline_theme='tomorrow'
    let g:airline_powerline_fonts=1
else
    let g:airline_powerline_fonts=0
endif
let g:airline#extensions#whitespace#checks = []
let g:airline_section_y = airline#section#create_right(['%{printf("%s%s",&fenc,&ff!="unix"?":".&ff:"")}'])
let g:airline_section_z = airline#section#create_right(['%3l:%2c'])
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#ctrlp#color_template = 'replace'

" Ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Java support
" ------------
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab
autocmd FileType java setlocal commentstring=//\ %s

" C# support
" -----------
autocmd FileType cs setlocal tabstop=8 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cs setlocal commentstring=//\ %s

" C/Object-C/C++ support
" ----------------------
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,objc setlocal commentstring=//\ %s
let c_no_curly_error=1
let g:syntastic_cpp_include_dirs = ['include', '../include']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_c_include_dirs = ['include', '../include']
let g:syntastic_c_compiler = 'clang'

" JavaScript support
" ------------------
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType javascript noremap <buffer> <leader>r :call JsBeautify()<cr>
autocmd FileType javascript let b:javascript_fold = 0
let javascript_enable_domhtmlcss=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args='--config ~/.vim/extern-cfg/jshint.json'

" CMake support
" -------------
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

" YAML support
" ------------
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
autocmd BufNewFile,BufRead *.sls setlocal ft=yaml


" """"""""""""""""""""""""""""""""""""""""""""""""
" ==================== Colors ====================

" Use syntax highlighting and color scheme
syntax enable

if has("gui_running")
    colorscheme fruity
    set guifont=Source_Code_Pro:h11
endif

highlight ColorColumn ctermbg=Green

" Use 256 colors in color schemes
set t_Co=256
set term=screen-256color

" Highlight excess line length in python
autocmd FileType python highlight Excess ctermbg=8
autocmd FileType python match Excess /\%80v.*/
autocmd FileType python set nowrap

" Use slightly dimmer text for the normal group
highlight Normal ctermfg=254 ctermbg=0
