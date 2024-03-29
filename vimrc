set encoding=utf-8

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Sarasa\ Mono\ SC\ Nerd\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
" set guifont=Sarasa Mono SC Nerd\ Regular:h16
set guioptions=

set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" set foldmethod=indent   
" set foldnestmax=10
" set nofoldenable
" set foldlevel=2

set foldmethod=syntax
set foldlevelstart=99

filetype plugin indent on
filetype indent on

set clipboard=unnamed

syntax on
set re=0

set hlsearch
set relativenumber
" set number
set cursorline
set cursorcolumn

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'terryma/vim-expand-region'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'

Plug 'preservim/nerdtree'

Plug 'jiangmiao/auto-pairs'

Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'jremmen/vim-ripgrep'

Plug 'lifepillar/vim-solarized8'

Plug 'dyng/ctrlsf.vim'

Plug 'terryma/vim-expand-region'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" true color support
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set background=dark
colorscheme solarized8

" Set light/dark theme based on time
if strftime("%H") < 12 && strftime("%H") > 7
  set background=light
else
  set background=dark
endif

inoremap <silent>jk <esc>

let mapleader="\<space>"

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nnoremap <silent>cj <Plug>(easymotion-bd-w)
" nnoremap cl <Plug>(easymotion-overwin-line)
nnoremap <silent>cl <Plug>(easymotion-overwin-line)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Tell FZF to use RG - so we can skip .gitignore files even if not using
" :GitFiles search
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" If you want gitignored files:
"let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
function! GitFZF()
let path = trim(system('cd '.shellescape(expand('%:p:h')).' && git rev-parse --show-toplevel'))
if !isdirectory(path)
let path = expand('%:p:h')
endif
exe 'FZF ' . path
endfunction

let g:coc_global_extensions = ['coc-prettier','coc-html','coc-eslint','coc-vetur','coc-tsserver', 'coc-json','coc-css']

command! GitFZF call GitFZF()
nnoremap <silent>cpl :GitFZF<CR>

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
nnoremap <silent>xb :Buffers<CR>

command! -nargs=0 CopyRelativePath :let @*=expand("%")
command! -nargs=0 CopyAbsolutePath :let @*=expand("%:p")
command! -nargs=0 CopyFilename :let @*=expand("%:t")
nnoremap cpp :let @+ = expand("%")<CR>

nnoremap tt :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
let g:NERDTreeMinimalMenu=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

let g:user_emmet_install_global = 1
let g:user_emmet_expandabbr_key = '<c-j>'
let g:use_emmet_complete_tag = 1

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:ctrlsf_context = '-C 3'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_position = 'bottom'

nnoremap ck :CtrlSF<space>

nnoremap <C-p> <Plug>(expand_region_expand)

command! -nargs=0 ESLintFix :CocCommand eslint.executeAutofix

nnoremap <silent>ff :call CocAction('format')<CR>

nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)

function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
nmap <leader>z :call Zoom()<CR> 

map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)
