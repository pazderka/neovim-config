set nocompatible "Avoid headache
syntax on "Turn on syntax highlighting
filetype plugin indent on "Detection, plugins and indenting

call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
    Plug 'jiangmiao/auto-pairs' " Complete brackets
    Plug 'airblade/vim-gitgutter' " Integrate git
    Plug 'preservim/nerdtree' " File explorer
    Plug 'tpope/vim-fugitive' " Show diff
    Plug 'sheerun/vim-polyglot' " Language packs
    Plug 'sainnhe/gruvbox-material' " Color scheme
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better syntax highlight
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'Yggdroot/indentLine' " Show connecting vertical indent lines
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multi-line cursor
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } " Override native sorter
    Plug 'kyazdani42/nvim-web-devicons', " Show nice icons
    Plug 'heavenshell/vim-jsdoc', { 
        \ 'for': ['javascript', 'javascript.jsx','typescript'],
        \ 'do': 'make install'
    \}
call plug#end()

" Exit telescope on first escape
lua << EOS
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})
require("telescope").load_extension("fzf")


require("nvim-treesitter.configs").setup {
    ensure_installed = { "javascript", "vue", "python", "json", "css", "scss", "html", "jsdoc", "lua", "toml", "yaml" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}

require('lualine').setup {
    options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

EOS

set noerrorbells
set softtabstop=4
set shiftwidth=4
set ruler
set expandtab
set nohlsearch
set smartindent
set number
set relativenumber
set lazyredraw
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
set updatetime=100
set cul
set encoding=UTF-8
set colorcolumn=120
set hidden
set termguicolors
set scrolloff=8
set background=dark
set noshowmode
set clipboard=unnamedplus

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_visual = 'reverse'
let g:gruvbox_material_diagnostic_line_highlight = 1
colorscheme gruvbox-material "Set the best color scheme in the world

" Highlight vertical column
highlight ColorColumn ctermbg=0 guibg=#689d6a

set signcolumn=yes
" Hide colored spaces left to numbers
highlight! link SignColumn LineNr

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Enable JsDoc command
command! -register JsDoc call jsdoc#insert()

" Coc extensions
let g:coc_global_extensions = [
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-emmet',
            \ 'coc-vetur',
            \ 'coc-pyright',
            \ 'coc-tsserver']

" Show gitgutter symbols colored bg
let g:gitgutter_highlight_linenrs=1

" Nerdtree settings
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=40
let g:NERDTreeIgnore = ['node_modules']

" Hide multi-cursor warning conflict with autopairs
let g:VM_show_warnings = 0

" Set preprocessor
let g:vue_pre_processors = ['scss']

" Set leader to space 
let mapleader=" "

" Jump to existing window if possible
let g:fzf_buffers_jump = 1

" Toggle nerd tree 
nnoremap <silent><leader>c :NERDTreeToggle<CR>

" Show file explorer according to git files
nnoremap <silent><C-f> :Telescope git_files show_untracked=true<cr>

" Show file eplorer according to string match
nnoremap <silent><C-p> :Telescope live_grep<CR>

" Show buffers
nnoremap <silent><C-b> :Telescope buffers<CR>

" Jump between windows easily
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Toggle between tabs
nnoremap <silent><leader>n :tabprevious<CR>
nnoremap <silent><leader>m :tabnext<CR>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Git hunk remaps
nmap gs <Plug>(GitGutterPreviewHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)

" Git merge conflicts
nnoremap <silent><leader>gd :Gvdiffsplit!<CR>
nnoremap <silent><leader>gh :diffget //2<CR>
nnoremap <silent><leader>gl :diffget //3<CR> 

" Select completion by enter
inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Exit Vim if NERDTree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
\ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
