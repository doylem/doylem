" doylem's .vimrc configuration. Hack style.

" Base
set nocompatible "  we don't need to be compatible with vi at the expense of functionality any more.
set encoding=utf-8
set noexrc
syntax on
filetype plugin indent on

" General
set autochdir " always switch to the current file directory
set backspace=indent,eol,start " make backspace more flexible
set backup " make backup files
set backupdir=~/.vim/backup " where to put backup files
set directory=~/.vim/tmp " directory to place swap files in
set fileformats=unix,dos " support files, in this order
set mouse=a " use mouse everywhere
set noerrorbells " don't make noise

" Wildcards
set wildmenu " turn on command line completion wild style ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest " turn on wild mode huge list

" UI
set laststatus=2 " always show the status line
set lazyredraw " do not redraw while running macros
set linespace=0 " don't insert any extra pixel lines betweens rows
set matchpairs+=<:>,(:),{:},[:] " match braces/brackets
set ttyfast " fast terminal
set nofoldenable " Turn off folding
set nostartofline " leave my cursor where it was
set novisualbell " don't blink
set number " turn on line numbers
set numberwidth=4 " Display line numbers up to 9999 lines
set report=0 " tell us when anything is changed via :...
set ruler " Always show current positions along the bottom
set scrolloff=10 " Keep 10 lines (top/bottom) for scope
set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
set showcmd " show the command being typed
set showmatch " show matching brackets
set matchtime=2 " how many tenths of a second to blink matching brackets for
set sidescrolloff=10 " Keep 5 lines at the size

" Searching stuff
set hlsearch  " highlight search
set incsearch  " Incremental search, search as you type
set ignorecase " case insensitive by default
set smartcase " Ignore case when searching lowercase

" Text Formatting / Layout
set autoindent " auto indent on new lines
set completeopt= " don't use a pop up menu for completions
set listchars=tab:\|\ " >-,trail:. show tabs as pipes
set list " we do want to show tabs, to ensure we get them out of my files
set expandtab " no real tabs please! uses spaces instead.
set nowrap " do not wrap line
set shiftround " round to tabstop when indenting
set shiftwidth=2 " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=2 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=2 " real tabs should be 8, but they will show with set list on
set pastetoggle=<F12> "Toggle beetween paste mode and normal mode

" set colorcolumn=85 " Highlight the barrier beyond which lines of code should be on the next line
set noswapfile " Don't create a swapfile when editing

" Vim 7.3 commands
set undofile " creates an undo file so you can undo things after closing & re-opening.
set undodir=~/.vim/undo " directory to place undo files in

" Mac OSX
autocmd! GUIEnter * set vb t_vb=
set visualbell t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Funky / experimental snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable Up, Down, Left, Right... use h,j,k,l instead!
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" save when exiting the buffer or losing focus
au FocusLost,WinLeave * :silent! w

" Allow :W to still happen
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Allow saving of root files by ':w!!' as sudo
cmap w!! w !sudo tee > /dev/null %

" Toggle between absolute and relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number " absolute line numbers
  else
    set relativenumber " line numbers relative to current line position
  endif
endfunc
" Press Ctrl + N to toggle between absolute and relative line numbers
nnoremap ,n :call NumberToggle()<cr>

" Toggle light and dark backgrounds
function! ReverseBackground()
 let Mysyn=&syntax
 if &bg=="light"
 se bg=dark
 else
 se bg=light
 endif
 syn on
 exe "set syntax=" . Mysyn
": echo "now syntax is "&syntax
endfunction
command! Invbg call ReverseBackground()
noremap <F9> :Invbg<CR>

" Press F2 to word-wrap a block of text.
" map #2 !}fmt -65

" To save, press ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Find git's inline diffs more easily
nnoremap <Leader>fd /<<<<<<\_.\{-}>>>>>><CR>

" SPLITS!!!
" Create a blank vertical split
nnoremap <leader>w :vnew<CR>
" Create a vertical split and start using it
nnoremap <leader>W <C-w>v<C-w>l
" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

" Use alt-[arrow] to select the active split!
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" format JSON files all prettyish
map <leader>jt !python -m json.tool<CR>

" ,(spacebar) to remove all extraneous whitepace  - WARNING, causes crazy git diffs
map ,<SPACE> :%s/\s\+$//e<CR><Esc>:nohlsearch<CR>

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" make sure json files use json syntax highlighting
au! BufRead,BufNewFile *.json set filetype=json 

" Terminal Cursor
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Remove the small delay when changing from insert mode back to normal mode
set timeoutlen=1000 ttimeoutlen=0


"""""""""""""""""""""""""""""""""""""""""""""""
" Plugin based stuff
"""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""
" Rainbow parens
" Not sure how i feel about this  yet... would have to configure different
" colours
"""""""""""""""
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces


"""""""""""""""
" Semantic highlight TODO: set good colours...
" https://github.com/jaxbot/semantic-highlight.vim.git
""""""""""""""""
let g:semanticTermColors = [28,1,2,3,4,5,6,7,25,9,10,34,12,13,14,15,16,125,124,19]
:nnoremap <Leader>sh :SemanticHighlightToggle<cr>

""""""""""""""""
" Syntastic
""""""""""""""""
" Syntastic plugin next/prev
nnoremap <c-n> :lnext<CR>
nnoremap <c-N> :lnext<CR>

" Recommended default settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_loc_list_height = 5 " Use this option to specify the height of the location lists that syntastic opens
let g:syntastic_auto_loc_list = 2 " Auto close error window, but do not open automatically

" check JS as ES (will parse JSX also)
let g:syntastic_javascript_checkers = ['eslint']

" vim-jsx
let g:jsx_ext_required = 0

""""""""""""""""
" vim-javascript
" https://github.com/pangloss/vim-javascript
""""""""""""""""
" let g:javascript_conceal_this = "@"
" set conceallevel=1

""""""""""""""""
" Javascript libraries syntax
""""""""""""""""
autocmd BufReadPre *.js,*.coffee,*.cjsx let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js,*.coffee,*.cjsx let b:javascript_lib_use_react = 1
autocmd BufReadPre *.js,*.coffee,*.cjsx let b:javascript_lib_use_flux = 1
autocmd BufReadPre *.js,*.coffee,*.cjsx let b:javascript_lib_use_jasmine = 1


""""""""""""""""
" Tab / TabLine / vim-tabber
" https://github.com/fweep/vim-tabber
""""""""""""""""
set tabline=%!tabber#TabLine()
let g:tabber_wrap_when_shifting = 1

nnoremap <silent> <C-t>            :999TabberNew<CR>
nnoremap <silent> <Leader><Leader> :TabberSelectLastActive<CR>
nnoremap <silent> <Leader>tn       :TabberNew<CR>
nnoremap <silent> <Leader>tm       :TabberMove<CR>
nnoremap <silent> <Leader>tc       :tabclose<CR>
nnoremap <silent> <Leader>tl       :TabberShiftLeft<CR>
nnoremap <silent> <Leader>tr       :TabberShiftRight<CR>
nnoremap <silent> <Leader>ts       :TabberSwap<CR>
nnoremap <silent> <Leader>1        :tabnext 1<CR>
nnoremap <silent> <Leader>2        :tabnext 2<CR>
nnoremap <silent> <Leader>3        :tabnext 3<CR>
nnoremap <silent> <Leader>4        :tabnext 4<CR>
nnoremap <silent> <Leader>5        :tabnext 5<CR>
nnoremap <silent> <Leader>6        :tabnext 6<CR>
nnoremap <silent> <Leader>7        :tabnext 7<CR>
nnoremap <silent> <Leader>8        :tabnext 8<CR>
nnoremap <silent> <Leader>9        :tabnext 9<CR>

" alternative tab navigation
nnoremap <S-h> gT
nnoremap <S-l> gt

" Toggle hardmode
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" switch.vim setup
nnoremap <leader>- :Switch<cr>

" Press F11 to toggle JSlint
map #11 :JSLintToggle

" Emmet-vim... easier HTML and CSS coding
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-Z>'

" Auto-align on equal signs (=) using Tabularize.
" https://gist.github.com/MaienM/1258015
" inoremap <silent> = =<Esc>:call <SID>ealign()<CR>a
function! s:ealign()
  let p = '^.*=[^>]*$' 
  if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
    Tabularize/=/l1
    normal! 0
    call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"Toggle twiddle case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv


"""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""

" Q. How can I open a NERDTree automatically when vim starts up if no files were specified?
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Nerdtree tabs!!!
" let g:nerdtree_tabs_open_on_console_startup=1

" Q. How can I map a specific key or shortcut to open NERDTree?
map #5 :NERDTreeTabsToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""

" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

" Ignore these directories
set wildignore+=*/out/**
set wildignore+=*/vendor/**

" Search in certain directories a large project (hardcoded for now)
cnoremap %projmp <c-r>=expand('~/src/marketplace')<cr>
" ga = go assets
map <Leader>ga :CtrlP %projmp/app/assets/<cr>
" gv = go views
map <Leader>gv :CtrlP %projmp/app/views/<cr>
" gs = go specs
map <Leader>gs :CtrlP %projmp/spec/<cr>

" Search in certain directories a large project (hardcoded for now)
cnoremap %projlb <c-r>=expand('~/src/loading_bay')<cr>
" glb = go loading bay
map <Leader>glb :CtrlP %projlb<cr>

""""""""""""""""""""""""""""""""""""""""""""""
" TMUX
""""""""""""""""""""""""""""""""""""""""""""""
" tmux navigator
" let g:tmux_navigator_no_mappings = 1

" Use pbpaste/pbcopy inside the terminal
set clipboard=unnamed

"""""""""""""""""""""""
" Auto enable paste mode when pasting
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
"""""""""""""""""""""""

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()



""""""""""""""""""""""""""""""""""""""""""""""
""""""""" Pathogen
""""""""""""""""""""""""""""""""""""""""""""""

execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEMES!
"""""""""""""""""""""""""""""""""""""""""""""""

" When solarized is used in tmux, use 16 colors - this then uses the
" terminal's color palette which should be set to solarized by manual
let g:solarized_visibility="high"
let g:solarized_contrast="high"
let g:solarized_termcolors=16

set background=dark
colorscheme solarized

" I want fancy powerline symbols everywhere
let g:airline_powerline_fonts = 1


"""""""""""""""""""""""""""""""""""""""""""""""
" GUI Settings
"""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12 " set the font manually
    :set guioptions-=m  "remove menu bar
    :set guioptions-=T  "remove toolbar
    :set guioptions-=r  "remove right-hand scroll bar
    let g:solarized_termcolors=256
    set guioptions-=e
    set fuopt+=maxhorz " set full width and height on fullscreen
    " set initial window hight bigger so that fullscreen is easier
    set lines=999 columns=9999
endif

if has("gui_vimr")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12 " VimR does not play nice with thematic config settings, set the font manually
    let g:solarized_termcolors=256
    set guioptions-=e
endif

