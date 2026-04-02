" Disable compatibility with Vi to enable
" Vim's extended features and modern behaviors.
set nocompatible

" Use system clipboard
"
" https://stackoverflow.com/a/39313208
if has('macunix')
    set clipboard=unnamed
elseif has('unix')
    set clipboard=unnamedplus
endif

" Enable a number column with numbers relative
" to the current line the cursor is on.
set relativenumber

" 1. Enable filetype detection to apply filetype-specific
" settings e.g. syntax highlighting
" 2. Enable filetype plugins.
" 3. Enable the indent plugin for automatic indentation
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Convert the tab character into spaces
set expandtab

" Define the width of a tab character.
set tabstop=4

" Number of spaces to insert on tab key press
set softtabstop=4

" Number of spaces to use for auto-indentation
set shiftwidth=4

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Show quickfix list easier
nnoremap <Leader>q :copen<CR>

" Setup key mappings for fzf.vim
"
" Fuzzy find files
noremap <silent> <leader>ff :Files<CR>
" live grep (need ripgrep)
noremap <silent> <leader>fg :Rg<CR>
" grep word under cursor
noremap <silent> <leader>fw :Rg <C-R><C-W><CR>
" recently opened files
noremap <silent> <leader>fr :History<CR>
" recently opened files
noremap <silent> <leader>fh :Helptags<CR>
" open buffers
noremap <silent> <leader>fb :Buffers<CR>
" lines in current buffer
noremap <silent> <leader>fl :BLines<CR>
" lines across all buffers
noremap <silent> <leader>fL :Lines<CR>
" command history
noremap <silent> <leader>f: :History:<CR>
" search history
noremap <silent> <leader>f/ :History/<CR>
" marks
noremap <silent> <leader>fm :Marks<CR>
" ctags
noremap <silent> <leader>ft :Tags<CR>

" Configure yank highlighting to be quicker (200ms) and not show
" up in visual mode
let g:highlightedyank_highlight_duration = 200
let g:highlightedyank_highlight_in_visual = 0
