augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
augroup END

" required by obsidian.nvim
" This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
let g:pencil#conceallevel = 2 
