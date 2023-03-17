set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax enable
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set smarttab

set hlsearch
set smartcase
set ignorecase

set encoding=utf8
set linebreak
set scrolloff=2
set wrap

set laststatus=2
set ruler
set wildmenu
set cursorline
set number
" set noerrorbells
set mouse=a
set background=dark

set backspace=indent,eol,start

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
