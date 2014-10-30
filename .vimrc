" .vimrc

" Tabs are four spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2

set guifont=Source\ Code\ Pro:h14

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set number                        " show line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set mouse=a                       " enable mouse support
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=4                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set nofoldenable                  " disable code folding
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
runtime macros/matchit.vim        " use % to jump between start/end of methods

" map :W to :w
command WQ wq
command Wq wq
command W w
command Q q

" See whitespaces
set list
set listchars=tab:\ \ ,trail:.

set background=dark

highlight ColorColumn ctermbg=7
highlight ColorColumn guibg=Gray

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn ctermbg=white
endif
