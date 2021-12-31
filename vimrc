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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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

Plug 'airblade/vim-gitgutter' " https://github.com/airblade/vim-gitgutter

Plug 'janko/vim-test' " like vim-rspec but multi language/test support

Plug 'scrooloose/nerdtree' " directory tree GUI

Plug 'ntpeters/vim-better-whitespace' "highlight whitespace https://github.com/ntpeters/vim-better-whitespace

Plug 'mbbill/undotree' " graphcial undo history, see https://github.com/mbbill/undotree

Plug 'Xuyuanp/nerdtree-git-plugin' " show which files have changes since last commit

" vim themes =======

Plug 'https://github.com/sainnhe/everforest'

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

" =======================================================================
" COLOR SCHEME / THEME
" =======================================================================

" see options: https://github.com/morhetz/gruvbox/wiki/Configuration
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set guifont=Mononoki_Nerd_Font:h11
set background=dark

colorscheme everforest

" ========================================================================
" fzf setup
" ========================================================================

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" fzf.vim
" https://github.com/junegunn/fzf.vim
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" temp hide status line when in use
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> <leader>f :RG<cr>
nnoremap <silent> <leader>F :FZF<cr>

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
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1

let g:strip_max_file_size = 1000

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

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" =======================================================================
" POWERLINE / LIGHTLINE
" =======================================================================

" Fix for powerline bug
set laststatus=2

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status'
\ },
\ }

" =======================================================================
" VIM COMMENTARY
" =======================================================================
" https://github.com/tpope/vim-commentary
noremap \ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

"" =======================================================================
" ALE
" =======================================================================

" ALE linting events
" augroup ale
"   autocmd!

"   if g:has_async
"     autocmd VimEnter *
"       \ set updatetime=1000 |
"       \ let g:ale_lint_on_text_changed = 0
"     autocmd CursorHold * call ale#Queue(0)
"     autocmd CursorHoldI * call ale#Queue(0)
"     autocmd InsertEnter * call ale#Queue(0)
"     autocmd InsertLeave * call ale#Queue(0)
"   else
"     echoerr "The dotfiles require NeoVim or Vim 8"
"   endif
" augroup END

" =======================================================================
" COC SETUP
" =======================================================================

" COC - PRETTIER https://github.com/neoclide/coc-prettier

command! -nargs=0 Prettier :CocCommand prettier.formatFile

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
nnoremap <silent> <c-e> :TmuxNavigateUp<cr>
nnoremap <silent> <c-i> :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" ================================================
"
" copy/paste modifier
" https://stackoverflow.com/questions/39645253/clipboard-failure-in-tmux-vim-after-upgrading-to-macos-sierra
set clipboard=unnamed
