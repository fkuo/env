set nocompatible               " be iMproved
filetype off                   " required!

"execute pathogen#infect()
set rtp+=~/.vim/bundle/vundle/ 
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'Valloric/YouCompleteMe'
Bundle 'marijnh/tern_for_vim'
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'airblade/vim-gitgutter'
Bundle 'yaifa.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jelera/vim-javascript-syntax'

syntax enable
set number
set colorcolumn=81
set cursorline

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list

set listchars=tab:,.,trail:_,extends:#,nbsp:. " Highlight problematic whitespace
set scrolloff=5 " minimum lines to keep above and below cursor
set autoindent
set backspace=indent,eol,start
set hlsearch
set incsearch
set mouse=a
set ignorecase
set smartcase
set laststatus=2 " always show the status bar
set encoding=utf-8
"set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
set nomodeline " don't read modelines
if has('mouse_sgr')
    set ttymouse=sgr " select columns > 223
endif
set nojoinspaces " don't insert double space after '.' when joining or gq-ing

" tab completion settings.
" first tab hit will complete as much as possible
" the second tab hit will provide a list
" the third and subsequent tabs will cycle through completion options
set wildmode=longest,list,full
set wildmenu

set background=dark
"set background=dark
let g:solarized_termcolors=256
let g:solarized_termcolors = 16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
highlight colorcolumn ctermbg=0
highlight cursorline ctermbg=0
highlight SignColumn ctermbg=8
highlight LineNr ctermbg=8 ctermfg=10
"highlight clear SignColumn
"highlight clear cursorline
"highlight cursorline guisp=lightgrey ctermbg=lightgrey
"highlight SignColumn ctermfg=10 ctermbg=0 guifg=Yellow
"highlight clear LineNr
"highlight LineNr ctermfg=grey

" bell alert when a search wraps
nnoremap <expr> n search(@/, 'nW' . (v:searchforward ? '' : 'b')) ? 'n' : "\<ESC>" . (&ws ? 'n' : '')
nnoremap <expr> N search(@/, 'nW' . (v:searchforward ? 'b' : '')) ? 'N' : "\<ESC>" . (&ws ? 'N' : '')

" change easymotion leader key to just one <Leader> default: '<Leader><Leader>'
" motion keys: fFtTwWbBeEjknN and ge and gE
let g:EasyMotion_leader_key = '<Leader>'

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" \p toggles paste mode
nnoremap \p :set paste!<CR>

" \h turns off highlighting
nnoremap \h :nohl<CR>

" \\t toggles NERDTree
nnoremap \\t :NERDTreeToggle<CR>

" \\p for ctrlp
nnoremap \\p :CtrlPMixed<CR>

" \\g toggles git gutter
nnoremap \\g :ToggleGitGutter<CR>

" turn off git gutter by default
" let g:gitgutter_enabled = 0

" \m toggles mark signs
nnoremap \\m :SignatureToggle<CR>

nmap <silent> ]h :GitGutterNextHunk<CR>
nmap <silent> [h :GitGutterPrevHunk<CR>

" rebind VJ to avoid that thing that happens when you go into to
" Visual Line mode and try to select down/up too fast and it ends up joining
" the lines or opening help
nnoremap J <nop>
nnoremap VJ Vj
nnoremap VK Vk

" Easier moving in tabs and windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" alias :W -> :w, :Q -> :q, :Wq -> :wq from holding shift too long
" http://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim#3879737
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))

command -range Copy silent '<,'>w ! pbcopy

" Map ctrl+c to match escape exactly since:
" CTRL-C          Quit insert mode, go back to Normal mode.  Do not check for
"                abbreviations.  Does not trigger the |InsertLeave| autocommand
"                event. 
map <silent> <C-c> <Esc>:nohl<CR>
