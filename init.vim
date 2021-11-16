call plug#begin('~/.vim/plugged')
  " Plugin section
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-vetur', 'coc-svelte', 'coc-angular', 'coc-deno', 'coc-python', 'coc-pairs', 'coc-snippets', 'coc-kotlin', 'coc-go', 'coc-sql']
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'vimlab/split-term.vim'
  Plug 'tpope/vim-surround'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wakatime/vim-wakatime'
  Plug 'scrooloose/nerdcommenter'
  Plug 'burner/vim-svelte'
  Plug 'posva/vim-vue'
  Plug 'vim-python/python-syntax'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/seoul256.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'elzr/vim-json'
  Plug 'mxw/vim-jsx'
  Plug 'udalov/kotlin-vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'hsanson/vim-android'
  Plug 'APZelos/blamer.nvim'
call plug#end()

" Config section
set number
set clipboard=unnamedplus
set tabstop=2
set shiftwidth=2
set expandtab
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
colorscheme seoul256
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusLine = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:blamer_enabled = 1
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
" use alt+hjkl/opt+hjkl to move between split/vsplit panels
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <C-p> :FZF<CR>

" Set F5 to compile Android projects and install to emulator
nmap <F5> <ESC>:Gradle assembleDebug<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Set autosync in Android projects when build.gradle is written to
au BufWrite build.gradle call gradle#sync()

" Set lightline theme and add gradle integrations
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ }
set noshowmode
