" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim-Plug (Plugin Manager) Setup
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set nocompatible              " be iMproved, required
filetype off                  " required

" Vim-plug setup
call plug#begin('~/.local/share/nvim/plugged')

" list plugins here:
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'christoomey/vim-tmux-navigator'

" fzf install and plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'skammer/vim-css-color' " Preview CSS colors

Plug 'dense-analysis/ale' " ALE Linter https://github.com/dense-analysis/ale#usage

Plug 'vim-ruby/vim-ruby'   " Ruby syntax highlighting and support

Plug 'tpope/vim-surround'  " Enable the ability to delete surrounding quotes, brackets, etc

Plug 'tpope/vim-repeat'    " Adds more functionality to dot command repeating

Plug 'tpope/vim-bundler'   " bundler wrapper to be used with rails vim

Plug 'tpope/vim-fugitive'  " Custom git wrappr

Plug 'tpope/vim-dispatch'  " Allows temp tasks to be popped up

Plug 'tpope/vim-eunuch'    " Vim sugar for UNIX shell commands https://github.com/tpope/vim-eunuch

Plug 'tpope/vim-rails'     " use :E for rails convention (jump to testings specs for a model)

Plug 'tpope/vim-commentary' " commenting made easy

Plug 'simeji/winresizer' " easy resize windows with Ctrl E and normal nav keys

Plug 'terryma/vim-multiple-cursors' " enable multiple cursor mode

Plug 'airblade/vim-gitgutter' " https://github.com/airblade/vim-gitgutter

Plug 'janko/vim-test' " like vim-rspec but multi language/test support

Plug 'scrooloose/nerdtree' " directory tree GUI

Plug 'ntpeters/vim-better-whitespace' "highlight whitespace https://github.com/ntpeters/vim-better-whitespace

Plug 'mbbill/undotree' " graphcial undo history, see https://github.com/mbbill/undotree

Plug 'Xuyuanp/nerdtree-git-plugin' " show which files have changes since last commit

" vim themes =======

Plug 'morhetz/gruvbox'

Plug 'https://github.com/chriskempson/tomorrow-theme'

Plug 'https://github.com/nanotech/jellybeans.vim'

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'jacoborus/tender.vim'

Plug 'tomasr/molokai'

" end vim themes ===

Plug 'itchyny/lightline.vim'

Plug 'ryanoasis/vim-devicons' " vim compatible icons

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

" more natural splits, move split panes to right and bottom
set splitbelow
set splitright

" ========================================================================
" fzf setup
" ========================================================================

"" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PrePro'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
" command! -bang -nargs=* GGrep
"   \ call fzf#vim#grep(
"   \   'git grep --line-number '.shellescape(<q-args>), 0,
"   \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

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
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=100
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

" =======================================================================
" BETTER WHITESPACES
" =======================================================================

" enable highlighting and whitespace striping on save
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

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
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
map <leader><C-n> :NERDTreeToggle<CR>

" Close vim if nerdtree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =======================================================================
"  COC CONFIG
" =======================================================================

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Show all diagnostics
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

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
" VIM COMMENTARY
" =======================================================================

" let g:winresizer_start_key = '<leader><c-e>'

" =======================================================================
" COLOR SCHEME / THEME
" =======================================================================

" see options: https://github.com/morhetz/gruvbox/wiki/Configuration
"set guifont=Literation_Mono_Nerd_Font:h11
"set guifont=Mononoki_Nerd_Font:h11

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" set colorscheme (theme)

let g:molokai_original=1

" colorscheme jellybeans
colorscheme molokai
" colorscheme tender
" colorscheme dracula


" colorscheme gruvbox
" let g:gruvbox_italic=1
" set hard contrast for dark mode
" set guifont, MUST BE A NERD FONT for icon display to work
" set background=dark  "setting drk mode
" let g:gruvbox_contrast_dark= 'hard'
" let g:gruvbox_number_column ='bg'

"set guifont=Fira_Code_Nerd_Font:h11

" =======================================================================
" COC SETUP
" =======================================================================

" COC - PRETTIER https://github.com/neoclide/coc-prettier

command! -nargs=0 Prettier :CocCommand prettier.formatFile


" =======================================================================
" VIM-SIGNIFY
" =======================================================================

" default updatetime 4000ms is not good for async update
set updatetime=100

" =======================================================================
" MULTIPLE CURSOR SETTINGS
" =======================================================================

" " disable plugin setting keybindings automatically
" let g:multi_cursor_use_default_mapping=0

" " Default mapping
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'

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

" these Ctrl mappings work well when Caps Lock is mapped to Ctrl
" nmap <silent> t<C-n> :TestNearest<CR>
" nmap <silent> t<C-f> :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-g> :TestVisit<CR>

" RSPEC-VIM CONFIG
" RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" ================================================
"  Vim Tmux Navigator
" ================================================

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" ================================================
"
" copy/paste modifier
" https://stackoverflow.com/questions/39645253/clipboard-failure-in-tmux-vim-after-upgrading-to-macos-sierra
set clipboard=unnamed
