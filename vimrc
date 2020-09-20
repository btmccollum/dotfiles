" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim-Plug (Plugin Manager) Setup
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set nocompatible              " be iMproved, required
filetype off                  " required

" Vim-plug setup
call plug#begin('~/.local/share/nvim/plugged')

" fzf install and plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" list plugins here:
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'simeji/winresizer' " easy resize windows with Ctrl E and normal nav keys
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'  " Fuzzy finding with Ctrl P
Plug 'skammer/vim-css-color' " Preview CSS colors  
Plug 'tpope/vim-surround'  " Enable the ability to delete surrounding quotes, brackets, etc
Plug 'tpope/vim-repeat'    " Adds more functionality to dot command repeating 
Plug 'tpope/vim-bundler'   " bundler wrapper to be used with rails vim
Plug 'tpope/vim-fugitive'  " Custom git wrapper
Plug 'tpope/vim-dispatch'  " Allows temp tasks to be popped up
Plug 'vim-ruby/vim-ruby'   " Ruby syntax highlighting and support
Plug 'tpope/vim-rails'     " use :E for rails convention (jump to testings specs for a model)
Plug 'tpope/vim-commentary' " commenting made easy
Plug 'janko/vim-test' " like vim-rspec but multi languate/test support
Plug 'scrooloose/nerdtree' " directory tree GUI
Plug 'Xuyuanp/nerdtree-git-plugin' " show which files have changes since last commit
Plug 'jacoborus/tender.vim'
Plug 'itchyny/lightline.vim'
" Plug 'ryanoasis/vim-devicons' " vim compatible icons

call plug#end()

" =======================================================================
" GENERAL CONFIG
" =======================================================================
"
" Pick a leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping 
set visualbell

" Make splits go to the right of buffer, not left
set splitright

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=4
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" remember additional commands
set history=1000

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
" map <leader>l :set list!<CR> " Toggle tabs and EOL


" ========================================================================
" fzf setup
" ========================================================================

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

"" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

"" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" ========================================================================
" Ruby stuff
" ========================================================================

syntax on                 " Enable syntax highlighting

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

" =======================================================================
" VIM NAVIGATION
" =======================================================================
"
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" =======================================================================
"  NERD TREE
" =======================================================================
" Open NERDTree on start and autofocus window
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
map <C-n> :NERDTreeToggle<CR>

" Close vim if nerdtree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =======================================================================
" POWERLINE
" =======================================================================

" Fix for powerline bug
set laststatus=2

" =======================================================================
" VIM COMMENTARY
" =======================================================================
" https://github.com/tpope/vim-commentary
noremap \ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

" =======================================================================
" COLOR SCHEME / THEME
" =======================================================================

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

colorscheme tender

" =======================================================================
" VIM TEST CONFIG 
" =======================================================================
" https://github.com/janko/vim-test

let test#strategy = "basic"

" Use vim-rspec bindings for vim-test
map <leader>h :TestFile<CR>
map <leader>s :TestNearest<CR>
map <leader>l :TestLast<CR>
map <leader>a :TestSuite<CR>


" copy/paste modifier 
" https://stackoverflow.com/questions/39645253/clipboard-failure-in-tmux-vim-after-upgrading-to-macos-sierra
set clipboard=unnamed
