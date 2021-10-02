" Avoid headache
set nocompatible
    call plug#begin('~/.vim/plugged')
         Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
         Plug 'jiangmiao/auto-pairs' " Complete brackets
         Plug 'airblade/vim-gitgutter' " Integrate git
         Plug 'preservim/nerdtree' " File explorer
         Plug 'tpope/vim-fugitive' " Show diff
         Plug 'ryanoasis/vim-devicons' " Pretty icons in file explorer
         Plug 'Xuyuanp/nerdtree-git-plugin' " Git changes in nerdtree
         Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Add syntax for nerdtree
         Plug 'sheerun/vim-polyglot' " Language packs
         Plug 'morhetz/gruvbox' " Color theme
         Plug 'itchyny/lightline.vim' " Line with info
         Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Quick file finder
         Plug 'junegunn/fzf.vim' " Quick file finder
         Plug 'heavenshell/vim-jsdoc', {
             \ 'for': ['javascript', 'javascript.jsx','typescript'],
             \ 'do': 'make install'
         \} " Generate jsdoc
    call plug#end()
    syntax on "Turn on syntax highlighting
    filetype plugin indent on "Detection, plugins and indenting
    colorscheme gruvbox "Set the best color scheme in the world
                                                                                                                            
    "Enable gui colors
     if !has('gui_running')
       set t_Co=256
     endif
                                                                                                                            
    set noerrorbells
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set ruler
    set expandtab
    set nohlsearch
    set smartindent
    set nu
    set nowrap
    set smartcase
    set smarttab
    set autoindent
    set ignorecase
    set noswapfile
    set nobackup
    set nowritebackup
    set cmdheight=1
    set shortmess+=c
    set undodir=~/.vim/undodir
    set undofile
    set incsearch
    set updatetime=300
    set cul
    set encoding=UTF-8
    set colorcolumn=120
    set hidden
    set relativenumber
    set termguicolors
    set scrolloff=8
    set signcolumn=yes
    set background=dark
    set laststatus=2
    set noshowmode
    set sc
    set sol
   
    " Additional plugin settings
    highlight ColorColumn ctermbg=0 guibg=lightgrey
    highlight! link SignColumn LineNr
   
    let g:coc_global_extensions = [
                \ 'coc-css',
                \ 'coc-browser',
                \ 'coc-html',
                \ 'coc-json',
                \ 'coc-prettier',
                \ 'coc-cssmodules',
                \ 'coc-emmet',
                \ 'coc-eslint',
                \ 'coc-html',
                \ 'coc-htmldjango',
                \ 'coc-htmlhint',
                \ 'coc-html-css-support',
                \ 'coc-stylelint',
                \ 'coc-yaml',
                \ 'coc-vetur',
                \ 'coc-tsserver']
   let g:user_emmet_mode='n'
   let g:user_emmet_leader_key=','
   let g:coc_filetype_map = {
        \ 'htmldjango': 'html',
        \ }
   let g:lightline = {
         \ 'colorscheme': 'one',
         \ 'active': {
         \   'left': [ [ 'mode', 'paste' ],
         \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
         \ },
         \ 'component_function': {
         \   'gitbranch': 'FugitiveHead'
         \ },
         \ }
  
   let s:palette = g:lightline#colorscheme#one#palette
   let s:palette.tabline.tabsel = [ [ '#000000', '#98c379', 255, 255, 'bold' ] ]
   unlet s:palette

   let g:gitgutter_highlight_linenrs = 1
   let NERDTreeShowHidden = 1
   let NERDTreeMinimalUI=1
   let g:NERDTreeWinSize=40
   let g:AutoPairsFlyMode = 1
  
   " Remaps
   nnoremap <C-n> :NERDTreeToggle<CR>
   nnoremap <C-f> :GFiles<CR>
   nnoremap <C-p> :Rg<CR>
   nnoremap <C-b> :Buffers<CR>
   nnoremap <C-h> <C-w>h
   nnoremap <C-l> <C-w>l
   nnoremap <C-Left> :tabprevious<CR>
   nnoremap <C-Right> :tabnext<CR>

   " Auto commands
   
   " Fix scss problems
   autocmd FileType scss setl iskeyword+=@-@
   
   " Exit Vim if NERDTree is the only window left
   autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
         \ quit | endif                                                                                                      
                                                                                                                             
   " Start NERDTree when Vim starts with a directory argument.
   autocmd StdinReadPre * let s:std_in=1
   autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

   " Always show the signcolumn, otherwise it would shift the text each time
   " diagnostics appear/become resolved.
   if has("nvim-0.5.0") || has("patch-8.1.1564")
     " Merge signcolumn and number column into one if possible
     set signcolumn=number
   else
     set signcolumn=yes
   endif
    
   " Use <c-space> to trigger completion.
   if has('nvim')
     inoremap <silent><expr> <c-space> coc#refresh()
   else
     inoremap <silent><expr> <c-@> coc#refresh()
   endif
