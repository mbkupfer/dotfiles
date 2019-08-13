set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


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

let mapleader = ","

" SETTINGS
set updatetime=100 " Mainly to make git-gutter speedier
set completeopt=longest,menuone
set previewheight=8
"set hlsearch
"set incsearch
set number
set relativenumber
set foldnestmax=1
set splitright
set nowrap
set whichwrap=b,s
set foldmethod=indent
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
set pythonthreedll=/usr/local/bin/python3

" Save with leader
nnoremap <leader>w :w<cr>
" Quick goto buffer map
nnoremap gb :ls<CR>:b

" Easier to use semicolon
nnoremap ; :
vnoremap ; :

" special settings to make links bars
" visible in vim help
set conceallevel=0
hi link HelpBar Normal " KEYMAPS
hi link HelpStar Normal
" Quick exit from insert mode
:imap jk <Esc>
inoremap jk <Esc>
" Shift tab to indent/unindent
:inoremap <S-Tab> <C-O><lt><lt>
:nnoremap <Tab> >>
:nnoremap <S-Tab> <lt><lt>
:vnoremap <Tab> >
:vnoremap <S-Tab> <lt>

" Move lines using shift
:nnoremap <S-Up> :m-2<CR>
:nnoremap <S-Down> :m+<CR>
:inoremap <S-Up> <Esc>:m-2<CR>
:inoremap <S-Down> <Esc>:m+<CR>

" Change working directory to current file dir
:noremap <leader>cd :cd %:p:h<CR>

" Open up line above in one step
inoremap <leader>o <C-o><S-o>

" ABBREVIATIONS
" quick alias for vimrc. re has no real significance
" just that it is easy to type compared to rc.
ca re $HOME/.vimrc
ca e Exp


" OTHER

let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" Specify python version for ultisnips
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.config/snippets']
let g:UltiSnipsSnippetsDir=$HOME.'/.config/snippets'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsListSnippets = '<c-l>'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsEditSplit = 'vertical'
let g:ultisnips_python_style = 'numpy'
let g:ultisnips_python_quoting_style = 'single'


" ALE settings
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
" Navigate to errors quickly
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


" Add file directory to Vim path
" Useful for opening nested files in
" projects without changing cwd
autocmd BufRead *
 \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
 \ exec "set path+=".s:tempPath

autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType jsx setlocal formatoptions+=r
autocmd FileType jsx setlocal indentkeys-=o
