set nocompatible              " be iMproved, required
filetype off                  " required

"---------Have to run this to make ,gg work"
"brew install the_silver_searcher
"then run :PluginInstall
"----------------
"
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
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'    " go to relevant spec
Plugin 'tpope/vim-commentary' "plugin for using gc to comment out lines
Plugin 'Shougo/neocomplete.vim'  "neocomplete
Plugin 'vim-scripts/matchit.zip' " match beginning and end of the block, like {/( do-end, etc.
call vundle#end()            " required
filetype plugin indent on    " required

"clean setup requires
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"Run :PluginInstall to install or uninstall plugins
"
"-------Non Plugin customization--------
"----------------
"Neocomplete config
"----------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" " Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"----------------
"end of Neocompatible config
"----------------
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
"-----------------------
"Ag stuff
"----------------------
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" nice ,gg

"-------------from Bryan--------
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ag_working_path_mode="r"
nnoremap <Leader>gg :Ag ""<Left>|                                         " Recursively grep for text matches in all files under the current directory
vnoremap <Leader>gg <Esc>:Ag "<C-r>=GetVisual()<CR>"<Left>|               " Same as above, but using the selected text
nnoremap <Leader>gf :AgFile ""<Left>|                                     " Recursively grep for file matches in the current directory
vnoremap <Leader>gf <Esc>:AgFile "<C-r>=GetVisual()<CR>"<Left>|
nnoremap <Leader>gg :Ag ""<Left>
"-------------from Bryan--------

" Ag command
let g:ag_highlight=1

" Use Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

 " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"-----------------------
"end of Ag stuff
"----------------------
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

"Cool searching stuff
set incsearch
set hlsearch

set backspace=indent,eol,start    "fixes backspace in insert mode
set confirm                       "Ask to save or use hidden buffer
autocmd BufNewFile,BufRead Gemfile set filetype=ruby "set ruby syntax in Gemfile

"Better up/down on wrapped lines
nnoremap j gj
nnoremap k gk

"Clear the search to get rid of highlighting
nnoremap <CR> :let @/=""<CR><CR>

" strip trailing whitespace:
" using command at the bottom, which strips whitespaces and leave cursor where
" it has been
" autocmd BufWritePre * :%s/\s\+$//e

map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

"-------------------
"trying to fix jumping cursor
"--------------------
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
let g:syntastic_auto_jump = 0
