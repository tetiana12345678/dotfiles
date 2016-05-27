set nocompatible              " be iMproved, required
filetype off                  " required

"-----------Plugins go here-----------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'bling/vim-airline'  " Lean & mean status/tabline for vim that’s light as air
Plugin 'bogado/file-line'     "works for open files on specified lines. :e bla-bla:67
Plugin 'christoomey/vim-tmux-navigator'  "to switch beetwen tabs with ctrl + vim navigation key [hjkl]
Plugin 'elixir-lang/vim-elixir' "Elixir syntax highlight
Plugin 'git://git.wincent.com/command-t.git'  " Git plugin not hosted on GitHub
Plugin 'gmarik/Vundle.vim'  " let Vundle manage Vundle, required
Plugin 'kien/ctrlp.vim'     "Fuzzy file, buffer search. ctrl+p
Plugin 'rking/ag.vim'       " silversearch to make ,gg work
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic' " Syntax check hacks for Vim, see: http://vimawesome.com/plugin/syntastic
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'    " go to relevant spec
Plugin 'tpope/vim-commentary' "plugin for using gc to comment out lines
Plugin 'vim-scripts/matchit.zip' " match beginning and end of the block, like {/( do-end, etc.
call vundle#end()            " required
filetype plugin indent on    " required

"clean setup requires
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"Run :PluginInstall to install or uninstall plugins
"
"-------Non Plugin customization--------
"
"remap leader key to comma
let mapleader = ","

"For lots of cool Vim things
set nocompatible
set encoding=utf-8

" Airline, see:
" https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x
set laststatus=2
let g:airline_powerline_fonts = 1

set smartindent         " Enable smart-indent
set smarttab            " Enable smart-tabs
set softtabstop=2       " Number of spaces per Tab
set expandtab           " Replace tabs with spaces

" Highlight matching brace
set showmatch
"reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" nice ,gg
"---------Have to run this to make ,gg work"
"brew install the_silver_searcher
"then run :PluginInstall
"----------------
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ag_working_path_mode="r"
nnoremap <Leader>gg :Ag ""<Left>

set autoindent          " Auto-indent new lines
"set solarized colorscheme
syntax enable
set background=dark
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
colorscheme solarized
set colorcolumn=80

"path options to the files
set wildmode=longest,list

"Syntax highlighting
syntax enable
filetype on
filetype plugin on
filetype plugin indent on

"Tab settings - 2 spaces instead of a tab
set autoindent
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

set list listchars=tab:\ \ ,trail:·   " Display tabs and trailing spaces visually
"Line numbers and visual stuff
set ruler
set number

" CtrlP
let g:ctrlp_by_filename = 1

" Ag command
let g:ag_highlight=1

"Syntastic error message highlight
" ====[ Syntastic ]====
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1                " Populate the locations list with the warnings
let g:syntastic_check_on_open = 1                           " Run Syntastic when opening a file
let g:syntastic_check_on_wq = 0                             " Skip Syntastic when closing a file
let g:syntastic_html_tidy_ignore_errors=["proprietary attribute", "trimming empty", "<form> lacks \"action\"", "> is not recognized!", "discarding unexpected", "<img> lacks \"src\""]

"Cool searching stuff
set incsearch
set hlsearch

" Use Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

 " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set backspace=indent,eol,start    "fixes backspace in insert mode
set confirm                       "Ask to save or use hidden buffer
autocmd BufNewFile,BufRead Gemfile set filetype=ruby "set ruby syntax in Gemfile

"Better up/down on wrapped lines
nnoremap j gj
nnoremap k gk

"Clear the search to get rid of highlighting
nnoremap <CR> :let @/=""<CR><CR>

" strip trailing whitespace:
autocmd BufWritePre * :%s/\s\+$//e

map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>
