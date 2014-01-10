" .vimrc 
" Original by Kevin Robayna - http://kevinrobayna.eu http://alanct.com/


" """"""""""""""""""""""""""""""""""""""""""""""""
" =============== General Settings ===============

" Title
set title
set titleold="Terminal"
set titlestring=%F

" Set Number
set number

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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CTRLP support
let g:ctrlp_map = '<Leader>o'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:top,min:1,max:20'
nnoremap <leader><tab> :CtrlPMRU<CR>

" python support
" --------------
" don't highlight exceptions and builtins. I love to override them in local
" scopes and it sucks ass if it's highlighted then. And for exceptions I
" don't really want to have different colors for my own exceptions ;-)

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
            \ formatoptions=croqj softtabstop=4 textwidth=74 comments=:#\:,:#
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0
let python_slow_sync=1

let g:syntastic_python_checkers=['flake8', 'python']

" Don't warn on
" E121 continuation line indentation is not a multiple of four
" E128 continuation line under-indented for visual indent
" E711 comparison to None should be 'if cond is not None:'
" E301 expected 1 blank line, found 0
" E261 at least two spaces before inline comment
" E241 multiple spaces after ':'
" E124 closing bracket does not match visual indentation
" E126 continuation line over-indented for hanging indent
" E721 do not compare types, use 'isinstance()'

let g:syntastic_python_flake8_args='--ignore=E121,E128,E711,E301,E261,E241,E124,E126,E721
            \ --max-line-length=84'
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

" CSS support
" -----------
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal commentstring=/*\ %s\ */
autocmd FileType css noremap <buffer> <leader>r :call CSSBeautify()<cr>

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
endif

" Use 256 colors in color schemes
set t_Co=256
set term=screen-256color

" Highlight excess line length in python
autocmd FileType python highlight Excess ctermbg=8
autocmd FileType python match Excess /\%80v.*/
autocmd FileType python set nowrap

" Use slightly dimmer text for the normal group
highlight Normal ctermfg=254 ctermbg=0
