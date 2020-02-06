set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" General
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'suy/vim-context-commentstring'

" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'plytophogy/vim-virtualenv'

" Linting
Plugin 'w0rp/ale'

" JS/JSX plugins
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'mattn/emmet-vim'
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Set leader key


""""""""""""""
"  Settings  "
""""""""""""""

set spelllang=en_us
set updatetime=100 " Mainly to make git-gutter speedier
set completeopt=longest,menuone
set previewheight=8
set number
set relativenumber
set nowrap
set splitright
set whichwrap=b,s
set showcmd
set ruler
syntax enable
set antialias
set smartcase
set ts=4
set shiftwidth=4
set expandtab
set smartindent
set mouse=a

""""""""""
"  Maps  "
""""""""""
let mapleader = ","

" Correct navigation with wrapped lines
nnoremap j gj
nnoremap k gk

" Open preview window tag on double click
map <2-LeftMouse> :exe "ptag ". expand("<cword>")<CR>
" Save with leader
nnoremap <leader>w :w<cr>
" Quick goto buffer map
nnoremap gb :ls<CR>:b

" Easier to use semicolon
nnoremap ; :
vnoremap ; :

" Quick exit from insert mode
imap jk <Esc>
inoremap jk <Esc>
" Shift tab to indent/unindent
inoremap <S-Tab> <C-O><lt><lt>
nnoremap <Tab> >>
nnoremap <S-Tab> <lt><lt>
vnoremap <Tab> >
vnoremap <S-Tab> <lt>

" Move individual lines using shift + arrow
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Change working directory to current file dir
noremap <leader>cd :cd %:p:h<CR>
noremap <leader>lcd :lcd %:p:h<CR>
noremap <leader>tcd :tcd %:p:h<CR>

" Open up line above in one step
inoremap <leader>o <C-o><S-o>

" Split window using "|" and "-"
nnoremap <C-w>\ :vsplit<CR>
nnoremap <C-w>- :split<CR>

" Move text down a line without leaving normal mode
nnoremap <CR> i<CR><ESC>

""""""""""""""""""""""
"  F(1-12) mappings  "
""""""""""""""""""""""
"F1 - Help shortcut
nnoremap <F2> :UltiSnipsEdit!<CR>|" Prompt to edit snippets
nnoremap <F3> :set hlsearch!<CR>:set incsearch!<CR>|"Toggle hlsearching
"F4
"F5 
"F6
"F7
nnoremap <F7> :set spell!<CR>|" toggle spellcheck
"F8 - ALEFix
"F9
"F10
"F11
"F12
"

"""""""""""""""""""
"  Abbreviations  "
"""""""""""""""""""

" quick alias for vimrc. re has no real significance
" just that it is easy to type compared to rc.
ca re $HOME/.vimrc
ca e Exp


"""""""""""""""""""""""""""
"  Plugin configurations  "
"""""""""""""""""""""""""""

" GitGutter
nmap ghp <Plug>GitGutterPreviewHunk
nmap ghs <Plug>GitGutterStageHunk
nmap ghu <Plug>GitGutterUndoHunk
nmap ghn <Plug>GitGutterNextHunk
nmap ghN <Plug>GitGutterPrevHunk

" Ultisnips
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.config/snippets']
let g:UltiSnipsSnippetsDir=$HOME.'/.config/snippets'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsListSnippets = '<c-l>'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsEditSplit = 'vertical'
let g:ultisnips_python_style = 'numpy'
let g:ultisnips_python_quoting_style = 'single'


" ALE settings
nmap <F8> <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_use_global_executables = 1
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'python': ['black'],
\    'javascript': ['prettier']
\}
let g:ale_linters = {'python': ['pylint']}
let g:ale_python_pylint_options = '--rcfile $HOME/.config/pylintrc'
let g:ale_javascript_prettier_executable = 'prettier'
let g:ale_python_black_options = '--skip-string-normalization'
let g:ale_python_pylint_change_directory = 0

" Emmet settings
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Jedi vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
" let g:jedi#completions_enabled = 0
"""""""""""""""""""
"  Auto commands  "
"""""""""""""""""""

" Add file directory to Vim path
" Useful for opening nested files in
" projects without changing cwd
autocmd BufRead *
 \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
 \ exec "set path+=".s:tempPath

autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType jsx setlocal formatoptions+=r
autocmd FileType jsx setlocal indentkeys-=o
autocmd FileType python setlocal foldmethod=indent foldnestmax=1

