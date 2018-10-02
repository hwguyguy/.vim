if !has('nvim')
	set nocompatible
	set pyx=3
endif

" Encoding {

set enc=utf8
set fenc=utf8
set fencs=ucs-bom,utf8,big5,cp936
set nobomb
let $LANG='en_US.UTF-8'
set langmenu=en_US.UTF-8
"lang mess en
"lan mes en_US.utf8

" }

" Variables {

let vimfiles_dir = $HOME.'/.vim/'
if has('win32')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" }

" vim-plug {

let vim_plug_location=expand(vimfiles_dir.'autoload/plug.vim')
if filereadable(vim_plug_location)
	let s:has_vim_plug = 1
else
	let s:has_vim_plug = 0
	if has('win32')
		echo "Click OK to install vim-plug"
	else
		echo "Installing vim-plug"
	endif
	silent execute '!mkdir -p '.vimfiles_dir.'autoload'
	silent execute '!mkdir -p '.vimfiles_dir.'plugged'
	silent execute '!curl -fLo '.vim_plug_location.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" https://github.com/junegunn/vim-plug/issues/469#issuecomment-226965736
function! UnPlug(repo)
	let repo = substitute(a:repo, '[\/]\+$', '', '')
	let name = fnamemodify(repo, ':t:s?\.git$??')
	call remove(g:plugs, name)
	call remove(g:plugs_order, index(g:plugs_order, name))
endfunction
command! -nargs=1 -bar UnPlug call UnPlug(<args>)

call plug#begin(vimfiles_dir.'plugged')

Plug 'bkad/CamelCaseMotion'
Plug 'Lokaltog/vim-easymotion'
Plug 'mbbill/undotree'
Plug 'sickill/vim-pasta'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tmhedberg/matchit'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-abolish'
"Plug 'vim-scripts/repeat-motion'
Plug 'chrisbra/NrrwRgn'
Plug 'machakann/vim-swap'
Plug 'dbakker/vim-projectroot'
if has('python3')
	Plug 'Shougo/denite.nvim'
else
	Plug 'Shougo/unite.vim'
endif
Plug 'Shougo/neoyank.vim'
if !has('win32')
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
	Plug 'junegunn/fzf.vim'
endif
Plug 'kien/ctrlp.vim'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'jlanzarotta/bufexplorer'
"Plug 'scrooloose/nerdtree'
"Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
if has('python3') && (has('nvim') || v:version >= 800)
	if !has('nvim')
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
		" pip install --user 'greenlet==0.4.10'
		" https://github.com/roxma/vim-hug-neovim-rpc/issues/3
	endif
	Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
elseif has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
	Plug 'Shougo/neocomplete.vim'
endif
if v:version >= 704
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'
endif
Plug 'justinmk/vim-gtfo'
"Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lilydjwg/colorizer'
"Plug 'osyo-manga/vim-anzu'
"Plug '907th/vim-auto-save'
"if !has('win32')
"    Plug 'benmills/vimux'
"endif
"Plug 'terryma/vim-multiple-cursors'

"if has('nvim') || v:version >= 800
"    Plug 'w0rp/ale'
"else
"    Plug 'scrooloose/syntastic'
"endif
"Plug 'pangloss/vim-javascript', { 'commit': '00624225c6b5ae7858d1186e99540022ced92f98' }
"Plug 'mxw/vim-jsx'
"Plug 'posva/vim-vue'
"Plug 'mattn/emmet-vim'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'cakebaker/scss-syntax.vim'
"Plug 'wavded/vim-stylus'
"Plug 'vim-ruby/vim-ruby'
"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-rails'
"Plug 'nginx/nginx', {'rtp': 'contrib/vim'}
"if !has('win32') && (has('python') || has('python3'))
"    Plug 'python-mode/python-mode', { 'branch': 'develop' }
"    Plug 'davidhalter/jedi-vim'
"    Plug 'zchee/deoplete-jedi'
"endif
"Plug 'fatih/vim-go'
"Plug 'leafgarland/typescript-vim'
"Plug 'Quramy/tsuquyomi'
"Plug 'StanAngeloff/php.vim', { 'for': 'php' }
"Plug 'autozimu/LanguageClient-neovim', { 'for': 'php', 'branch': 'next', 'do': 'bash install.sh' }
"Plug 'roxma/LanguageServer-php-neovim',  { 'for': 'php', 'do': 'composer install && composer run-script parse-stubs' }
Plug 'chrisbra/csv.vim'

let vimrc_plugins = vimfiles_dir.'vimrc.plugins'

if filereadable(vimrc_plugins)
	execute 'source '.vimrc_plugins
endif

call plug#end()

if s:has_vim_plug == 0
	echo "Installing plugins"
	:PlugInstall
endif

" }

" Appearence {

set nonu

" No beep
set noeb
set vb
set t_vb=

if has('nvim')
	let g:terminal_color_0='#2e3436'
	let g:terminal_color_1='#cc0000'
	let g:terminal_color_2='#4e9a06'
	let g:terminal_color_3='#c4a000'
	let g:terminal_color_4='#3465a4'
	let g:terminal_color_5='#75507b'
	let g:terminal_color_6='#06989a'
	let g:terminal_color_7='#d3d7cf'
	let g:terminal_color_8='#555753'
	let g:terminal_color_9='#ef2929'
	let g:terminal_color_10='#8ae234'
	let g:terminal_color_11='#fce94f'
	let g:terminal_color_12='#729fcf'
	let g:terminal_color_13='#ad7fa8'
	let g:terminal_color_14='#34e2e2'
	let g:terminal_color_15='#eeeeec'
endif

if has('gui_running')
	set guioptions-=b "horizontal scroll bar
	"set guioptions-=m "menu bar
	set guioptions-=T "toolbar
	set guioptions-=r "scrollbar
	set guicursor+=a:blinkon0
	set cursorline
	if has('win32')
		set guifont=Consolas:h11,DejaVu_Sans_Mono:h11,Lucida_Sans_Typewriter:h10,Lucida_Console:h10,Courier_New:h10 "gfn
	endif
	if has('unix')
		set guifont=Ubuntu\ Mono\ 12,DejaVu\ Sans\ Mono\ 10
	endif
	"winpos 400 20
	"set lines=34 columns=105
	"set linespace=1
else
	if &term == 'linux'
		" No blinking cursor in linux console
		"set t_ve+=[?81;0;112c
	else
		"let &titlestring = fnamemodify(expand('%:p'), ':~')
		set title
	endif

	set t_Co=256			"set terminal to 256 color
	set t_Sf=[3%p1%dm
	set t_Sb=[4%p1%dm

	if $COLORTERM == 'truecolor' || $TERM_PROGRAM == 'iTerm.app'
		set termguicolors
	endif

	colors wombat256
endif

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

let g:airline_theme='powerlineish'
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
function! s:AirlineAfterInit()
	if exists('g:loaded_airline') && g:loaded_airline && exists('*ProjectRootGuess')
		let g:airline_section_c='%f%m < %{ProjectRootGuess()}'
	endif
endfunction
autocmd VimEnter * call s:AirlineAfterInit()
let g:airline_section_y='[%{&ff}]%{&fenc}'
let g:airline_section_z='%l/%L %c,%v %P'
"let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#whitespace#checks = ['trailing']
let g:airline#extensions#anzu#enabled=0

" }

" Backup files {

" swap files
"set directory=$VIM/swp
set noswapfile

" backup files
set nobackup		" DON'T keep a backup file
set nowritebackup
"set backupdir=$VIM/bak

if !has('nvim')
	let &viminfo="'50,<0,s0,h,n" . vimfiles_dir . ".viminfo"
endif

let &undodir=vimfiles_dir.'.undo'
set undofile

" backup files edited from WinSCP
"if has('win32')
"	let g:my_save_cache_dir='C:\/app\/WinSCP\/cache\/scp[0-9]*\/'
"	let g:my_save_bak_dir='C:\/app\/WinSCP\/bak\/'
"	augroup my_save
"		autocmd!
"		autocmd BufWritePost *.php,*.phtml,*.js,*.css,*.csv call MySave()
"	augroup END
"endif

" }

" Buffers {

set hidden
set confirm

" }

" Change current directory automatically {

"set autochdir " auto change CWD to current buffer's directory
autocmd BufEnter * silent! lcd %:p:h " auto change dir to prevent plugin errors with autochdir
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" }

" Editing {

set wrap
set showmatch
set mouse+=a
"set scrolloff=4
set backspace=indent,eol,start
"set nrformats+=alpha " make <C-a> and <C-x> works on alpha numeric characters
set nrformats-=octal

" }

" File format {

" set default file format
set ffs=unix,dos

" }

" File type {

let g:ctab_filetype_maps=1

"autocmd BufRead,BufNewFile *.djhtml,*.peb setlocal filetype=jinja
autocmd BufRead,BufNewFile *.phtml setlocal filetype=phtml.php
autocmd BufRead,BufNewFile .babelrc setlocal filetype=json

au BufEnter * if &filetype == 'help' | :only | endif

" }

" Syntax {

syntax on

set nolist

"lcs, :digraph for symbol list, e.g. » symbol is ctrl+k then >>
set listchars=tab:»\ ,

"autocmd Syntax python setlocal list

" show python leading spaces
"highlight LeadingWhitespace ctermbg=red guibg=red
"autocmd Syntax python syn match LeadingWhitespace / \+/ contained
"autocmd Syntax python syn match MixedTabSpaceIndentation /^\s\+/ contains=LeadingWhitespace

" disable auto comment
"autocmd BufNewFile,BufRead * setlocal formatoptions-=r|setlocal formatoptions-=o
autocmd BufNewFile,BufRead * setlocal formatoptions-=o

autocmd Syntax perl setlocal include=\\<\\(require\\\|do\\)\\>

autocmd FileType clojure setlocal iskeyword-=/

augroup nginx_syntax
	autocmd!
	autocmd FileType nginx setlocal iskeyword-=. iskeyword-=/ iskeyword-=:
augroup END

" }

" Completion {

"set completeopt=menu,longest,preview
set completeopt=menu,longest

" }

" Indentation {

set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set cindent
set cinoptions=(0,u0,U0,m1,:0
set autoindent
let g:vim_indent_cont = &sw

augroup fortran_indent
	autocmd!
	autocmd FileType fortran setlocal tabstop=6
	autocmd FileType fortran setlocal shiftwidth=6
	autocmd FileType fortran setlocal expandtab
augroup END

let g:html_indent_inctags='p'

augroup ruby_indent
	autocmd!
	autocmd FileType ruby,eruby setlocal ts=2 sw=2 sts=2 et ai
augroup END

augroup javascript_indent
	autocmd!
	autocmd FileType javascript setlocal cinoptions=u0,U0,m1,:0
augroup END

augroup package_json_indent
	autocmd!
	autocmd BufRead,BufNewFile,BufEnter package.json setlocal ts=2 sw=2 sts=2 et ai
augroup END

augroup java_indent
	autocmd!
	autocmd FileType java setlocal cinoptions=j1,(0,m1,:0
augroup END

" press <tab> to indent in insert mode
"autocmd FileType perl,javascript,php,css setlocal cinkeys+=!<tab>
"autocmd FileType perl,javascript,php,css setlocal indentkeys+=!<tab>

" }

" Search {

set incsearch  " do incremental searching
set hlsearch   " highlight all search matches
set ignorecase " ignore case
set smartcase  " but don't ignore it, when search string contains uppercase letters

" }

" Folding {

set nofoldenable
set foldnestmax=4
set foldlevelstart=4
"set foldmarker=
let javascript_fold=1

" }

" Diff {

set diffopt=vertical

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
"function! s:LoadCustomConf()
"    let path=expand('%:p:h')
"    if has('win32')
"        let sep='\'
"        let root=strpart(path, 0, stridx(path, sep))
"    elseif has('unix')
"        let sep='/'
"        let root=$HOME
"    else
"        let sep='/'
"        let root=$HOME
"    endif
"    while (match(path, root) == 0)
"        if filereadable(path.'/.vim.custom')
"            break
"        endif
"        let path=strpart(path, 0, strridx(path, sep))
"    endwhile
"    if filereadable(path.'/.vim.custom')
"        let cmd='so '.path.'/.vim.custom'
"        let cmd=substitute(cmd, ' ', '\\ ', 'g')
"        execute cmd
"    endif
"endfunction
"augroup custom_conf
"    autocmd!
"    autocmd BufNewFile,BufRead * call s:LoadCustomConf()
"augroup END

" }

" netrw {

let g:netrw_liststyle=1

" }

" NERD Commenter {

let g:NERDDefaultAlign = 'left'

" }

" BufExplorer {

let g:bufExplorerShowNoName=1        " Show "No Name" buffers.
let g:bufExplorerShowRelativePath=1  " Show relative paths.

" }

" NERDTree {
if has_key(g:plugs, 'nerdtree')
	"autocmd VimEnter * NERDTree " start NERDTree automatically
	"autocmd VimEnter * wincmd p " move cursor to main window
	let NERDTreeShowHidden=1
	let NERDTreeIgnore=['^\.\.$', '^\.$']
endif
" }

" Denite {
if has_key(g:plugs, 'denite.nvim')
	call denite#custom#option('default', 'reversed', 1)

	call denite#custom#var('file_rec', 'command', ['ag', '--hidden', '--follow', '--nocolor', '--nogroup', '--skip-vcs-ignores', '-g', ''])

	call denite#custom#map(
		\ 'insert',
		\ '<C-n>',
		\ '<denite:move_to_next_line>',
		\ 'noremap'
		\)
	call denite#custom#map(
		\ 'insert',
		\ '<C-p>',
		\ '<denite:move_to_previous_line>',
		\ 'noremap'
		\)
	call denite#custom#map(
		\ 'insert',
		\ '<C-g>',
		\ '<denite:leave_mode>',
		\ 'noremap'
		\)

	call denite#custom#option('_', 'highlight_matched_char', 'Cursorline')
endif
" }

" Unite {
if has_key(g:plugs, 'unite.vim')
	if has('win32')
		let g:unite_data_directory = vimfiles_dir.'/.cache/unite'
	endif

	call unite#custom#profile('default', 'context', {
		\   'prompt': '❯ ',
		\   'start_insert': 1,
		\   'winheight': 10,
		\   'direction': 'botright',
		\ })
	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	call unite#filters#sorter_default#use(['sorter_rank'])
	let g:unite_source_history_yank_enable = 1
endif
" }

" fzf {
if has_key(g:plugs, 'fzf.vim')
	let $FZF_DEFAULT_COMMAND = 'ag --hidden --follow --nocolor --nogroup --skip-vcs-ignores -g ""'
endif
" }

" CtrlP {
if has_key(g:plugs, 'ctrlp.vim')
	let g:ctrlp_map = ''
	let g:ctrlp_prompt_mappings = {
		\ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
		\ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
		\ 'PrtHistory(-1)':       ['<m-n>'],
		\ 'PrtHistory(1)':        ['<m-p>'],
		\ }
	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
endif
" }

" Vim-CtrlP-CmdPalette {
if has_key(g:plugs, 'vim-ctrlp-cmdpalette')
	let g:ctrlp_cmdpalette_execute = 1
endif
" }

" YouCompleteMe {
if has_key(g:plugs, 'YouCompleteMe')
	let g:ycm_auto_trigger = 1
	if !exists("g:ycm_semantic_triggers")
		let g:ycm_semantic_triggers = {}
	endif
	let g:ycm_semantic_triggers['typescript'] = ['re![a-zA-Z0-9_.]']
endif
" }

" deoplete.nvim {
if has_key(g:plugs, 'deoplete.nvim')
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_complete_start_length = 1
	"let deoplete-source-attribute-min_pattern_length = 1
endif
" }

" Neocomplete {
if has_key(g:plugs, 'neocomplete.vim')
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_smart_case = 1
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
endif
" }

" Neosnippet {
if has_key(g:plugs, 'neosnippet')
	" For snippet_complete marker.
	"if has('conceal')
	"set conceallevel=2 concealcursor=i
	"endif

	let g:neosnippet#snippets_directory = vimfiles_dir.'snippets'

	if has('win32')
		let g:neosnippet#data_directory = vimfiles_dir.'.cache/neosnippet'
	endif
endif
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

" EasyMotion {
let g:EasyMotion_smartcase = 1
" }

" Auto Pairs {
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = '<M-]>'
" }

" vim-multiple-cursors {
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
	if exists(':NeoCompleteLock')==2
		exe 'NeoCompleteLock'
	endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
	if exists(':NeoCompleteUnlock')==2
		exe 'NeoCompleteUnlock'
	endif
endfunction
" }

" AutoSave {
if has_key(g:plugs, 'vim-auto-save')
	let g:auto_save = 1
	let g:auto_save_no_updatetime = 1
	let g:auto_save_silent = 1
	let g:auto_save_in_insert_mode = 0
	let g:auto_save_events = ['InsertLeave', 'TextChanged']
endif
" }

" ALE {
if has_key(g:plugs, 'ale')
	let g:ale_javascript_eslint_use_global = 1
	if executable('eslint_d')
		let g:ale_javascript_eslint_executable = 'eslint_d'
	endif
endif
" }

" Syntastic {
if has_key(g:plugs, 'syntastic')
	let g:syntastic_mode_map = { "mode": "active",
		\ "active_filetypes": [],
		\ "passive_filetypes": ["text", "vim", "python"] }
	let g:syntastic_check_on_open=1
	"let g:syntastic_enable_perl_checker=1
	"let g:syntastic_perl_checkers = ['perl', 'podchecker']
	if executable('eslint_d')
		let g:syntastic_javascript_checkers = ['eslint_d']
	endif
endif
" }

" vim-jsx {
if has_key(g:plugs, 'vim-jsx')
	let g:jsx_ext_required = 0
endif
" }

" Emmet-vim {
let g:user_emmet_expandabbr_key = '<C-j>'
" }

" python-mode {
if has_key(g:plugs, 'python-mode')
	let g:pymode_lint_ignore=["E302","E501","E265"]
	let g:pymode_options = 0
	let g:pymode_rope = 1
	let g:pymode_rope_completion = 0
	let g:pymode_rope_complete_on_dot = 0

	function! s:PymodeOptions()
		setlocal complete+=t
		setlocal formatoptions-=t
		setlocal nowrap
		setlocal textwidth=79
		setlocal commentstring=#%s
		setlocal define=^\s*\\(def\\\\|class\\)
	endfunction

	augroup pymode_options
		autocmd!
		autocmd FileType python call s:PymodeOptions()
	augroup END
endif
" }

" jedi-vim {
if has_key(g:plugs, 'jedi-vim')
	let g:jedi#completions_enabled = 0
endif
" }

" tsuquyomi {
if has_key(g:plugs, 'tsuquyomi')
	let g:tsuquyomi_disable_default_mappings = 1
	let g:tsuquyomi_shortest_import_path = 1
	let g:tsuquyomi_single_quote_import = 1

	if has_key(g:plugs, 'syntastic')
		let g:tsuquyomi_disable_quickfix = 1
		let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
	endif

	autocmd FileType typescript map <buffer> <C-]> <Plug>(TsuquyomiDefinition)
	autocmd FileType typescript map <buffer> <C-t> <Plug>(TsuquyomiGoBack)
	autocmd FileType typescript map <buffer> <C-u> <Plug>(TsuquyomiReferences)
	autocmd FileType typescript nmap <buffer> <C-e> <Plug>(TsuquyomiRenameSymbol)
	autocmd FileType typescript nmap <buffer> <C-i> <Plug>(TsuquyomiImport)
endif
" }

" vim-go {
if has_key(g:plugs, 'vim-go')
	augroup go_html_template_syntax
		autocmd BufRead,BufNewFile $GOPATH/src/*.html setlocal filetype=gohtmltmpl
	augroup END
endif
" }

" Eclim {

let g:EclimLocateFileDefaultAction = 'edit'

let g:EclimCompletionMethod = 'omnifunc'

if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java =
	\ '\%(\h\w*\|)\)\.\w*'

" }

" Commands {

function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)

execute 'command Rc :e '.vimfiles_dir.'vimrc'
CommandCabbr rc Rc
execute 'command Rcp :e '.vimfiles_dir.'vimrc.plugins'
CommandCabbr rcp Rcp
execute 'command Rco :e '.vimfiles_dir.'vimrc.override'
CommandCabbr rco Rco

" }

" Keybindings {

set winaltkeys=no

let mapleader = "\<Space>"

map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <C-j> o<esc>
nnoremap <C-k> O<esc>
nnoremap <F4> :tabe<Space>
nnoremap <F5> gT
nnoremap <F6> gt
nnoremap <F7> <C-w>v
nnoremap <F8> <C-w>s
nnoremap <F12> "=strftime("%c")<CR>p
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap \| :noh<cr>
nnoremap <kPlus> <C-a>
nnoremap <kMinus> <C-x>

inoremap <C-g> <esc>
inoremap <M-Space> <esc>
cnoremap <C-g> <C-c>
vnoremap <C-g> <esc>
vnoremap <M-Space> <esc>

inoremap <C-e> <C-o>A
inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <M-f> <C-o>w
inoremap <M-b> <C-o>b
inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
inoremap <M-d> <C-o>de
inoremap <M-h> <C-w>
inoremap <M-BS> <C-w>
inoremap <F12> <esc>"=strftime("%c")<CR>p
imap <M-n> <C-n>
imap <M-p> <C-p>
"imap </ </<C-x><C-o>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

cnoremap <C-A> <Home>
cnoremap <C-X><C-A> <C-A>
cnoremap <C-B> <Left>
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <M-d> <S-Right><C-W>

nnoremap <M-;> :call NERDComment(0, 'toggle')<cr>
vnoremap <M-;> :call NERDComment(0, 'toggle')<cr>
nnoremap <M-'> :call NERDComment(0, 'invert')<cr>
vnoremap <M-'> :call NERDComment(0, 'invert')<cr>
nnoremap <Leader>; :call NERDComment(0, 'toggle')<cr>
vnoremap <Leader>; :call NERDComment(0, 'toggle')<cr>
nnoremap <Leader>' :call NERDComment(0, 'invert')<cr>
vnoremap <Leader>' :call NERDComment(0, 'invert')<cr>

if has_key(g:plugs, 'unite.vim')
	nnoremap <Leader>bb :Unite buffer<cr>
	nnoremap <Leader>ff :Unite file file/new<cr>
	nnoremap <Leader>fp :UniteWithProjectDir file_rec:!<cr>
	nnoremap <Leader>y :Unite history/yank<cr>
	nnoremap <M-x> :Unite command<cr>
	inoremap <M-x> <C-o>:Unite command<cr>
endif

if has_key(g:plugs, 'denite.nvim')
	nnoremap <Leader>bb :Denite buffer<cr>
	nnoremap <Leader>ff :Denite file file:new<cr>
	nnoremap <Leader>fp :DeniteProjectDir file_rec<cr>
	nnoremap <Leader>y :Denite neoyank<cr>
	nnoremap <M-x> :Denite command<cr>
	inoremap <M-x> <C-o>:Denite command<cr>
endif

if has_key(g:plugs, 'fzf.vim') && !has('gui_running')
	nnoremap <Leader>bb :Buffers<cr>
	nnoremap <Leader>fp :ProjectRootExe Files<cr>
endif

if has_key(g:plugs, 'ctrlp.vim') && has_key(g:plugs, 'vim-ctrlp-cmdpalette')
	nnoremap <M-x> :CtrlPCmdPalette<cr>
	inoremap <M-x> <C-o>:CtrlPCmdPalette<cr>
endif

nnoremap <silent> + :let @/ .= '\\|\<'.expand('<cword>').'\>'<cr>

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
map <M-w> <Plug>(easymotion-bd-w)
map <Leader>s <Plug>(easymotion-s)
map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>l <Plug>(easymotion-bd-jk)
map <Leader>/ <Plug>(easymotion-bd-n)
map <Leader>r <Plug>(easymotion-repeat)

if has_key(g:plugs, 'vim-anzu')
	nmap n <Plug>(anzu-n-with-echo)
	nmap N <Plug>(anzu-N-with-echo)
endif

if has_key(g:plugs, 'deoplete.nvim')
	function! s:my_cr_function()
		return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	endfunction
	inoremap <silent><expr><CR> <C-r>=<SID>my_cr_function()<CR>
endif

if has_key(g:plugs, 'neocomplete.vim')
	inoremap <expr><C-/>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
		return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
		" For no inserting <CR> key.
		"return pumvisible() ? "\<C-y>" : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
endif

if has_key(g:plugs, 'neosnippet')
	imap <C-l>     <Plug>(neosnippet_expand_or_jump)
	smap <C-l>     <Plug>(neosnippet_expand_or_jump)
	xmap <C-l>     <Plug>(neosnippet_expand_target)

	" SuperTab like snippets behavior.
	imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		\ "\<Plug>(neosnippet_expand_or_jump)"
		\: pumvisible() ? "\<C-n>" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		\ "\<Plug>(neosnippet_expand_or_jump)"
		\: "\<TAB>"
endif

if !has('gui_running') && !has('nvim')
	set <M-;>=;
	set <M-x>=x
	set <M-s>=s
	set <M-w>=w
endif

if has('nvim')
	tnoremap <esc> <C-\><C-n>
endif

if has('gui_macvim') || has('gui_vimr')
	redir => s:map_output
	silent map
	redir END
	let s:lines = split(s:map_output, "\n")
	for s:line in s:lines
		if strpart(s:line, 3, 3) == '<M-'
			execute substitute(strpart(s:line, 0, 1).'noremap <D-'.strpart(s:line, 6), "\*", "", "")
		endif
	endfor
endif

" }

" Override {

let vimrc_override = vimfiles_dir.'vimrc.override'

if filereadable(vimrc_override)
	execute 'source '.vimrc_override
endif

" }

" vim: ts=4 sw=4 sts=0 noet
