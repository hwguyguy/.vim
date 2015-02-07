set nocompatible

"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

" Encoding {

set enc=utf8 fenc=utf8
set fencs=utf8,cp936,big5
let $LANG='en_US.UTF-8'
set langmenu=en_US.UTF-8
"lang mess en
"lan mes en_US.utf8

" }

" Variables {

if has('win32')
	if filereadable($HOME.'/_vimrc') || filereadable($HOME.'/vimfiles/vimrc')
		let vimfiles_dir = $HOME.'/vimfiles/'
	else
		let vimfiles_dir = $VIM.'/vimfiles/'
	endif
else
	let vimfiles_dir = $HOME.'/.vim/'
endif

" }

" Vundle {

let vundle_readme=expand(vimfiles_dir.'bundle/Vundle.vim/README.md')
if filereadable(vundle_readme)
	let has_vundle=1
else
	let has_vundle=0
	if has('win32')
		echo "Click OK to install Vundle."
	else
		echo "Installing Vundle..."
		echo ""
	endif
	silent execute '!mkdir -p '.vimfiles_dir.'bundle'
	silent execute '!git clone https://github.com/gmarik/Vundle.vim.git '.vimfiles_dir.'bundle/Vundle.vim'
endif

" set the runtime path to include Vundle and initialize
execute 'set rtp+='.vimfiles_dir.'bundle/Vundle.vim'
let path=vimfiles_dir.'bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'tomasr/molokai'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
"Plugin 'noahfrederick/vim-hemisu'
"Plugin 'vim-scripts/earendel'
"Plugin 'candycode.vim'
"Plugin 'cdaddr/gentooish.vim'
"Plugin 'endel/vim-github-colorscheme'
"Plugin 'twerth/ir_black'
"Plugin 'jpo/vim-railscasts-theme'
"Plugin 'nanotech/jellybeans.vim'
"Plugin 'vim-scripts/peaksea'
"Plugin 'vim-scripts/proton'
"Plugin 'vim-scripts/pyte'
"Plugin 'vim-scripts/xoria256.vim'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'Shougo/unite.vim'
if (has('lua') && (v:version > 703 || v:version == 703 && has('patch885')))
	Plugin 'Shougo/neocomplete.vim'
endif
Plugin 'kien/ctrlp.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'mbbill/undotree'
Plugin 'sickill/vim-pasta'
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'matchit.zip'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/vimfiler.vim'
Plugin 'majutsushi/tagbar'
Plugin 'lilydjwg/colorizer'
Plugin 'SmartCase'
Plugin 'tpope/vim-fugitive'
"if has('mac')
	"Plugin 'vim-scripts/ColorX'
"endif
"Plugin 'vim-scripts/repeat-motion'
if has('python')
	Plugin 'klen/python-mode'
endif
Plugin 'jmcomets/vim-pony'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-abolish'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if has_vundle == 0
	echo "Installing Plugins, please ignore key map error messages"
	:PluginInstall
endif

" }

" Appearence {

if exists("&relativenumber")
	set rnu			" line numbers, :set nu | set relativenumber, set rnu, set nornu
else
	set nu
endif

" Set color scheme according to current time of day.
function! s:HourColor()
	let hr = str2nr(strftime('%H'))
	if hr <= 2
		let i = 0
	elseif hr <= 18
		let i = 1
	else
		let i = 2
	endif
	let nowcolors = 'zenburn wombat256 zenburn'
	execute 'colorscheme '.split(nowcolors)[i]
	redraw
	"echo g:colors_name
endfunction

if has('gui_running')
	set guioptions-=b "horizontal scroll bar
	"set guioptions-=m "menu bar
	set guioptions-=T "toolbar
	set guioptions-=r "scrollbar
	set guicursor+=a:blinkon0
	if has('win32')
		set guifont=Consolas:h11,DejaVu_Sans_Mono:h11,Lucida_Sans_Typewriter:h10,Lucida_Console:h10,Courier_New:h10 "gfn
	endif
	if has('unix')
		set guifont=Ubuntu\ Mono\ 12,DejaVu\ Sans\ Mono\ 10
	endif
	"winpos 400 20
	"set lines=40 columns=140
	"set linespace=1 "lsp
	colorscheme solarized
	set bg=light
	"call s:HourColor()
	"set cursorline "cul, highlight current line
else
	set t_Co=256			"set terminal to 256 color
	set t_Sf=[3%p1%dm
	set t_Sb=[4%p1%dm
	colorscheme wombat256
endif

" No blinking cursor in linux console
"if &term == 'linux'
"	set t_ve+=[?81;0;112c
"endif

" }

" Status line / status bar {

set ruler			" show the cursor position all the time

" display status bar / status line
set laststatus=2
set statusline=%<%{getcwd()}\ %F%h%m%r%h%w%y[%{&ff}]%=\ col:%c%V\ lin:%l\/%L\ %P
"set statusline=%<%F%h%m%r%h%w%y\ [%{&ff}][%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ %{strftime(\"%x\,\ %H:%M\")}%=\ col:%c%V\ lin:%l\/%L\ %P
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
"set statusline=File:\ %m%<%f\%r%h%w\ [%{&ff},%{&fileencoding},%Y]%=\ [ASCII=\%03.3b]\ [Hex=\%02.2B]\ [Pos=%l,%v,%p%%]\ [Total\ Line=%L]

let g:airline_mode_map = {
		\ '__' : '-',
		\ 'n'  : 'N',
		\ 'i'  : 'I',
		\ 'R'  : 'R',
		\ 'c'  : 'C',
		\ 'v'  : 'V',
		\ 'V'  : 'V',
		\ '^V' : 'V',
		\ 's'  : 'S',
		\ 'S'  : 'S',
		\ '^S' : 'S',
		\ }
let g:airline_left_sep=''
let g:airline_right_sep=''
"if has('gui_running')
"	let g:airline_section_b='%{getcwd()}'
"endif
let g:airline_section_y='[%{&ff}]%{&fenc}'
let g:airline_section_z='%l/%L %c,%v %P'

" }

" Backup files {

" swap files
"set directory=$VIM/swp "set dir=
set noswapfile

" backup files
set nobackup		" DON'T keep a backup file
set nowritebackup
"set backupdir=$VIM/bak

set viminfo=

execute 'set undodir='.vimfiles_dir.'.undo'
set undofile

" backup files edited from WinSCP
if (has('win32'))
	let g:my_save_cache_dir='C:\/app\/WinSCP\/cache\/scp[0-9]*\/'
	let g:my_save_bak_dir='C:\/app\/WinSCP\/bak\/'
	augroup my_save
		autocmd!
		autocmd BufWritePost *.php,*.phtml,*.js,*.css,*.csv call MySave()
	augroup END
endif

" }

" Editing {

syntax on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nolist				"set indentation symbol

"lcs, :digraph for symbol list, e.g. » symbol is ctrl+k then >>
set listchars=tab:»\ ,

"autocmd Syntax python setlocal list

set mouse+=a				" use mouse in xterm to scroll
"set scrolloff=4 		" 4 lines bevore and after the current line when scrolling

set showmatch			" showmatch: Show the matching bracket for the last ')'?

set wrap

" disable auto comment
"autocmd BufNewFile,BufRead * setlocal formatoptions-=r|setlocal formatoptions-=o	"fo
autocmd BufNewFile,BufRead * setlocal formatoptions-=o	"fo

" show python leading spaces
"highlight LeadingWhitespace ctermbg=red guibg=red
"autocmd Syntax python syn match LeadingWhitespace / \+/ contained
"autocmd Syntax python syn match MixedTabSpaceIndentation /^\s\+/ contains=LeadingWhitespace

" press <tab> to indent in insert mode
autocmd FileType perl,javascript,php,css setlocal cinkeys+=!<tab>
autocmd FileType perl,javascript,php,css setlocal indentkeys+=!<tab>

autocmd FileType clojure setlocal iskeyword-=/

"set completeopt=menu,longest,preview
set completeopt=menu,longest
set hidden 				" allow switching buffers, which have unsaved changes
set confirm

autocmd Syntax perl setlocal include=\\<\\(require\\\|do\\)\\>

"set nrformats+=alpha " make <C-a> and <C-x> works on alpha numeric characters

let g:netrw_liststyle=1

let g:ctab_filetype_maps=1
autocmd Syntax javascript setlocal cinoptions=

au BufEnter * if &filetype == 'help' | :only | endif

" }

" File format {

" set default file format
set ffs=unix,dos

" }

" File type detection {

autocmd BufRead,BufNewFile *.djhtml setlocal filetype=htmldjango
autocmd BufRead,BufNewFile *.phtml setlocal filetype=phtml.php

" }

" Change current directory automatically {

"set autochdir " auto change CWD to current buffer's directory
autocmd BufEnter * silent! lcd %:p:h " auto change dir to prevent plugin errors with autochdir
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" }

" Indentation {

set tabstop=4			" ts
set shiftwidth=4		" sw: 4 characters for indenting
set softtabstop=0
set noexpandtab
set cindent
set cinoptions=(0,u0,U0
set autoindent

augroup fortran_indent
	autocmd FileType fortran setlocal tabstop=6
	autocmd FileType fortran setlocal shiftwidth=6
	autocmd FileType fortran setlocal expandtab
augroup END

let g:html_indent_inctags='p'

augroup ruby_indent
	autocmd FileType ruby setlocal ts=2 sw=2 sts=2 et ai
augroup END

" }

" Search {

set incsearch		" do incremental searching
set hlsearch " highlight all search matches
set ignorecase			" ignore case
set smartcase			" but don't ignore it, when search string contains uppercase letters

" }

" Folding {

set foldenable
set foldnestmax=4
autocmd Syntax c,cpp,java,perl,javascript setlocal foldmethod=syntax
autocmd Syntax c,cpp,java,perl,javascript normal zR
set foldlevelstart=4
"set foldmarker=
let javascript_fold=1

" }

" Command line {

set history=50		" keep 50 lines of command line history
set showcmd			" display incomplete commands
set wildmenu

"cnoreabbrev <expr> bc (getcmdtype()==':'&&getcmdline()=~#'^bc'?'Bclose':'bc')
cnoreabbrev <expr> bc ((getcmdtype() is# ':' && getcmdline() is# 'bc')?('Bclose'):('bc'))
cnoreabbrev <expr> wd ((getcmdtype() is# ':' && getcmdline() is# 'wd')?('w<bar>bd'):('wd'))

" }

" Local vimrc {

"set exrc " per directory .vimrc file, replaced by below function

" read local settings
function! s:LoadCustomConf()
	let path=expand('%:p:h')
	if has('win32')
		let sep='\'
		let root=strpart(path, 0, stridx(path, sep))
	elseif has('unix')
		let sep='/'
		let root=$HOME
	else
		let sep='/'
		let root=$HOME
	endif
	while (match(path, root) == 0)
		if filereadable(path.'/.vim.custom')
			break
		endif
		let path=strpart(path, 0, strridx(path, sep))
	endwhile
	if filereadable(path.'/.vim.custom')
		let cmd='so '.path.'/.vim.custom'
		let cmd=substitute(cmd, ' ', '\\ ', 'g')
		execute cmd
	endif
endfunction
augroup custom_conf
	autocmd!
	autocmd BufNewFile,BufRead * call s:LoadCustomConf()
augroup END

" }

" Taglist {

"let Tlist_JS_Settings = 'javascript;s:string;a:array;o:object;f:function'
if has('win32')
	let Tlist_Ctags_Cmd='"'.$VIM.'/ctags/ctags.exe"'
endif

" }

" Tagbar {

if has('win32')
	let g:tagbar_ctags_bin = ''.$VIM.'/ctags/ctags.exe'
endif

" }

" BufExplorer {

let g:bufExplorerShowNoName=1        " Show "No Name" buffers.
let g:bufExplorerShowRelativePath=1  " Show relative paths.

" }

" NERDTree {

"autocmd VimEnter * NERDTree " start NERDTree automatically
"autocmd VimEnter * wincmd p " move cursor to main window
let NERDTreeShowHidden=1
let NERDTreeIgnore=['^\.\.$', '^\.$']

" }

" vimfiler {

if has('win32')
	let g:vimfiler_data_directory = vimfiles_dir.'.cache/vimfiler'
endif

" }

" Unite {

if has('win32')
	let g:unite_data_directory = vimfiles_dir.'/.cache/unite'
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_source_history_yank_enable = 1

" }

" CtrlP {

if has('win32')
	let g:ctrlp_cache_dir = vimfiles_dir.'/.cache/ctrlp'
endif

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
  \ 'PrtHistory(-1)':       ['<m-n>'],
  \ 'PrtHistory(1)':        ['<m-p>'],
  \ }

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'

" }

" python-mode {

if has('python')
	let g:pymode_lint_ignore="E302,E501,E265"
endif

" }

" Syntastic {

let g:syntastic_check_on_open=1
"let g:syntastic_enable_perl_checker=1
"let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_mode_map = { "mode": "active",
			\ "active_filetypes": ["php"],
			\ "passive_filetypes": ["python"] }

" }

" EasyMotion {

let g:EasyMotion_smartcase = 1

" }

" Emmet-vim {

let g:user_emmet_expandabbr_key = '<C-j>'

" }

" Auto Pairs {

let g:AutoPairsShortcutBackInsert = '<M-]>'

" }

" Keybindings {

set winaltkeys=no "wak

let mapleader = "\<space>"

map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e

nnoremap <C-j> o<esc>
nnoremap <C-k> O<esc>
nnoremap <F4> :tabe<space>
nnoremap <F5> gT
nnoremap <F6> gt
nnoremap <F7> v
nnoremap <F8> s
nnoremap <F12> "=strftime("%c")<CR>p
inoremap <F12> <esc>"=strftime("%c")<CR>p

nnoremap <C-s> /<C-r>*<cr>ddggp$

nnoremap <M-h> h
nnoremap <M-j> j
nnoremap <M-k> k
nnoremap <M-l> l

nnoremap \| :noh<cr>

inoremap <C-g> <esc>
cnoremap <C-g> <C-c>
vnoremap <C-g> <esc>
nnoremap <M-x> :
inoremap <M-x> <C-o>:
inoremap <C-e> <C-o>A
inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <M-f> <C-o>w
inoremap <M-b> <C-o>b

nnoremap <M-;> :call NERDComment(0, 'toggle')<cr>
vnoremap <M-;> :call NERDComment(0, 'toggle')<cr>
nnoremap <M-'> :call NERDComment(0, 'invert')<cr>
vnoremap <M-'> :call NERDComment(0, 'invert')<cr>
nnoremap <Leader>; :call NERDComment(0, 'toggle')<cr>
vnoremap <Leader>; :call NERDComment(0, 'toggle')<cr>
nnoremap <Leader>' :call NERDComment(0, 'invert')<cr>
vnoremap <Leader>' :call NERDComment(0, 'invert')<cr>

nnoremap <Leader>bb :Unite -no-split -start-insert buffer<cr>
nnoremap <Leader>ff :Unite -no-split -start-insert file<cr>
nnoremap <Leader>fb :Unite -no-split -start-insert file buffer<cr>
nnoremap <Leader>fd :CtrlP<cr>
nnoremap <Leader>y :Unite history/yank<cr>

nnoremap <silent> + :let @/ .= '\\|\<'.expand('<cword>').'\>'<cr>

imap </ </<C-x><C-o>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

map <M-s> <Plug>(easymotion-s)
map <Leader>s <Plug>(easymotion-s)
map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>l <Plug>(easymotion-bd-jk)
map <Leader>/ <Plug>(easymotion-bd-n)
map <Leader>r <Plug>(easymotion-repeat)

" }

" Neocomplete {

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if has('win32')
	let g:neocomplete#data_directory = vimfiles_dir.'.cache/neocomplete'
endif

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : ''
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" }

" Override {

let vimrc_override = vimfiles_dir.'vimrc.override'

if filereadable(vimrc_override)
	execute 'source '.vimrc_override
endif

" }

" vim: ts=4 sw=4 sts=0 noet
