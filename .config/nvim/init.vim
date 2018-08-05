let g:mapleader="\<SPACE>"
set encoding=utf8
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode           " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the current line number
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set nosmarttab
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set noshowmode          " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

set cursorline
set cursorcolumn

set relativenumber      " Show the line numbers on the left side.
setglobal relativenumber

set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

set display+=lastline
set nostartofline       " Do not jump to first character with page commands.

set updatetime=500 " Let plugins show effects after 500ms, not 4s
set mouse-=a " Disable mouse click to go to position

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/docs?/

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Render characters quickly
set ttyfast

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

set ttimeout
set ttimeoutlen=0

" Tell Vim which characters to show for expanded TABs,
" and end-of-lines.
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set list                " Show problematic characters.

set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set incsearch

" Live substitution
set inccommand=split

" Disable swap and backup
set nobackup
set noswapfile
set nowritebackup

" Linebreak on 500 characters
set linebreak
set textwidth=500

"Smart indent
set smartindent
"Wrap lines
set wrap

set shell=/usr/bin/bash

set grepprg=rg\ --vimgrep

set colorcolumn=80

" Enable sql query syntax hightlighting in php files
let g:php_sql_query = 1
" Enable html syntax hightlighting in php files
let g:php_htmlInStrings = 1

" Remap comma to double dots
map , :

nnoremap <Leader>w :w!<CR>
nnoremap <Leader>W :SudoEdit<CR>

" Reload config on savings
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

map <Leader>c :tabedit ~/.config/nvim/init.vim<CR>

" Ex command control
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Cancel a search with esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Linux / windows ctrl+backspace ctrl+delete
" Note that ctrl+backspace doesn't work in Linux, so ctrl+\ is also available
imap <C-backspace> ú
imap <C-\> ú
imap <C-delete> ø

" Relative numbering
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <Leader>r :call NumberToggle()<cr>

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Remapping for switching windows when in terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" and in insert mode
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Close all open windows
noremap <C-q><C-q> :confirm qall<CR>

set lazyredraw
syntax sync minlines=128

" Wvp doesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

au BufEnter * set noro

if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" Neovim Terminal Colors
let g:terminal_color_0  = '#565575'
let g:terminal_color_1  = '#ff8080'
let g:terminal_color_2  = '#95ffa4'
let g:terminal_color_3  = '#ffe9aa'
let g:terminal_color_4  = '#91ddff'
let g:terminal_color_5  = '#c991e1'
let g:terminal_color_6  = '#aaffe4'
let g:terminal_color_7  = '#cbe3e7'
let g:terminal_color_8  = '#100e23'
let g:terminal_color_9  = '#ff5458'
let g:terminal_color_10 = '#62d196'
let g:terminal_color_11 = '#ffb378'
let g:terminal_color_12 = '#65b2ff'
let g:terminal_color_13 = '#906cff'
let g:terminal_color_14 = '#63f2f1'
let g:terminal_color_15 = '#a6b3cc'

augroup term
    autocmd!
    autocmd TermOpen * IndentLinesDisable
    autocmd TermOpen * set noshowmode
    autocmd TermOpen * set noruler
    autocmd TermOpen * set noshowcmd

    " Get terminal get input focus when switching to terminal window
    autocmd BufEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
augroup END

" Lots of scrollback in terminal
let g:terminal_scrollback_buffer_size = 50000

" Donwload vim-plug if missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim')
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
endfunction

""" vim-plug shortcuts
map <Leader>pi :PlugInstall<CR>
map <Leader>pu :PlugUpdate<CR>
map <Leader>pp :PlugUpgrade<CR>
map <Leader>pc :PlugClean<CR>

call plug#begin()

" Undo changes
Plug 'mbbill/undotree'
" Open undotree window
nnoremap <F5> :UndotreeToggle<cr>
" Focus undotree when showing it
let g:undotree_SetFocusWhenToggle = 1
" Add persistent undo history between files
if has('persistent_undo')
    set undofile
endif

" Hightlight html color tags
Plug 'lilydjwg/colorizer'

" Fuzzy picker
Plug 'srstevenson/vim-picker'
let g:picker_find_executable = 'rg'
let g:picker_find_flags = '--column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!docs?/*" --glob "!build/*" --glob "!opt/*" --glob "!vendor/*" --color never --threads 0 --no-messages --files'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let g:fzf_layout = { 'window': 'enew' }
" Fzz colors
let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
" Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages'
" Call fzf
noremap <Leader>z :Files<CR>
noremap <Leader>t :BTags<CR>
noremap <Leader>l :Lines<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>d :exe ':Look ' . expand('<cword>')<CR>
" Find command using fzf and ripgrep
command! -bang -nargs=* Look
  \ call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!docs?/*" --glob "!build/*" --glob "!opt/*" --glob "!vendor/*" --color "always" --threads 0 --no-messages '
  \   .shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up:60%'),
  \   <bang>0)
map <Leader>a :Look<CR>

augroup fzf_buffer
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Fast replace text
nnoremap <Leader>R :%s///g<left><left>

" Automaticcaly create dir when saving files
Plug 'pbrisbin/vim-mkdir'

" HTML syntax
Plug 'tpope/vim-eunuch'

" Open the file where it was closed
Plug 'dietsche/vim-lastplace'

" Quick windows close
Plug 'vim-scripts/quit-another-window'
nnoremap <Leader>qh :Qh <CR>
nnoremap <Leader>qj :Qj <CR>
nnoremap <Leader>qk :Qk <CR>
nnoremap <Leader>ql :Ql <CR>

" Swap windows
Plug 'wesQ3/vim-windowswap'
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yy :call WindowSwap#EasyWindowSwap()<CR>

" Search the selected text using *
Plug 'nelstrom/vim-visual-star-search'

" Version control
Plug 'tpope/vim-fugitive'

" Autocompletion framework
Plug 'ncm2/ncm2'
" ncm2
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

autocmd TextChangedI * call ncm2#auto_trigger()

set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" some completion sources
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-match-highlight'

" Completion for vim files
Plug 'ncm2/ncm2-vim'
Plug 'Shougo/neco-vim'

" Completion using include definitions
Plug 'ncm2/ncm2-neoinclude'
Plug 'Shougo/neoinclude.vim'

" Completion using syntax files
Plug 'ncm2/ncm2-syntax'
Plug 'Shougo/neco-syntax'

" Look.vim completion plugin
Plug 'filipekiss/ncm2-look.vim'

Plug 'ncm2/ncm2-highprio-pop'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" let g:LanguageClient_serverCommands = {
"     \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
"     \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
"     \ 'css': ['css-languageserver', '--stdio'],
"     \ 'python': ['pyls'],
"     \ }

" let g:LanguageClient_loadSettings = 1
" let g:LanguageClient_settingsPath = '/home/danyspin97/.config/nvim/settings.json'

" Use language server
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ncm2/ncm2-vim-lsp'

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" Enhance repeat key
Plug 'tpope/vim-repeat'

" Enhance closing parenthesis
Plug 'tpope/vim-surround'

" Comment lines easily
Plug 'tpope/vim-commentary'

" Better scrolling
Plug 'terryma/vim-smooth-scroll'
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>

Plug 'reedes/vim-wheel'
" Remap keys
let g:wheel#map#up   = '<m-y>'
let g:wheel#map#down = '<m-e>'

" Move between text objects using CamelCase
Plug 'bkad/CamelCaseMotion'
" Map keys
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Provide useful new movement
Plug 'matze/vim-move'

" Snippets for ultisnips
Plug 'honza/vim-snippets'

" Clipboard management
Plug 'vim-scripts/YankRing.vim'
" Show yankes
nnoremap <silent> <F6> :YRShow<CR>
" Increase window height
let g:yankring_window_height = 12
" Change keys for replacing
let g:yankring_replace_n_pkey = '<C-P>'
let g:yankring_replace_n_nkey = '<C-N>'

let g:yankring_max_history = 1000
let g:yankring_min_element_length = 3
let g:yankring_history_dir = '$HOME/.cache'

" Intend guides
Plug 'Yggdroot/indentLine'
" Set color for indenting character
let g:indentLine_color_gui = '#91ddff'
" Set new indenting char
let g:indentLine_char = '┆'
" Disable concealing
let g:indentLine_concealcursor = ''
" Set faster mode
let g:indentLine_faster=1
let g:indentLine_showFirstIndentLevel = 1

let g:indentLine_setColors=1

" Use editor config settings per project
Plug 'editorconfig/editorconfig-vim'

" Format using external tools
" Plug 'sbdchd/neoformat'
" " Disable alignment
" let g:neoformat_basic_format_align = 0
" " Enable tab to space conversion
" let g:neoformat_basic_format_retab = 1
" " Enable trimmming of trailing whitespace
" let g:neoformat_basic_format_trim = 1
" " Disable formatting
" let g:neoformat_enabled_sql = []
" " Use formatprg
" let g:neoformat_try_formatprg = 1
" " Don't put message errors in code
" let g:neoformat_only_msg_on_error = 1

" Automatically close Conditional statement in shell scripting
Plug 'tpope/vim-endwise'

" Enhance brackets and paranthesis
Plug 'jiangmiao/auto-pairs'

" Generate tags for code
Plug 'ludovicchabant/vim-gutentags'
" Enable
let g:gutentag_enabled = 1
" Set cache dir
let g:gutentags_cache_dir = '~/.cache/tags'

" HTML shortcuts
Plug 'mattn/emmet-vim'

" Language pack
Plug 'sheerun/vim-polyglot'

" Asynchronous build and make
Plug 'tpope/vim-dispatch'

" Linting
" Plug 'w0rp/ale'
" " Disable automatic lining on writing
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_set_loclist = 0
" " 1
" let g:ale_set_quickfix = 1
" " 1
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = 0
" " Disable completion
" let g:ale_completion_enabled = 0

" nmap <silent> <Leader>fp <Plug>(ale_previous_wrap)
" nmap <silent> <Leader>fn <Plug>(ale_next_wrap)

" let g:ale_cpp_cquery_options = '--log-file=/tmp/cq2.log'

" Close vim if the last window open is quickfix
aug QuickFixClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Writer plugins
Plug 'reedes/vim-pencil'
augroup Pencil
    autocmd!
    autocmd FileType markdown,mkd,asciidoc call EnterWriterMode()
augroup END

" Distraction free writing
Plug 'junegunn/goyo.vim'

" Enhance current line, hide useless information in other lines
Plug 'junegunn/limelight.vim'

" Tab keymaps
Plug 'DanySpin97/ttab.vim'
" Change key
let g:ttab_prefix = '<C-A>'
let g:ttab_shell = 'elvish'

" Browse documentation
Plug 'KabbAmine/zeavim.vim', {'on': [
            \   'Zeavim', 'Docset',
            \   '<Plug>Zeavim',
            \   '<Plug>ZVVisSelection',
            \   '<Plug>ZVKeyDocset',
            \   '<Plug>ZVMotion'
            \ ]}

Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
" Use one-character sneak instead of f
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map m <Plug>Sneak_s
map <C-m> <Plug>Sneak_S

" Elvish scripts syntax
Plug 'dmix/elvish.vim', { 'on_ft': ['elvish']}

Plug 'metakirby5/codi.vim'
let g:codi#rightsplit = 0
let g:codi#rightalign = 0

" Plug 'arakashic/chromatica.nvim'
" let g:chromatica#libclang_path = '/lib/libclang.so'
" let g:chromatica#enable_at_startup = 1

" Needed by coquille
Plug 'let-def/vimbufsync'
" Plugin for coq
Plug 'the-lambda-church/coquille'

Plug 'nightsense/seagrey'

" Latex plugin
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" Database wrapper
" Plug 'joereynolds/SQHell.vim'

" Manipulate buffers
Plug 'qpkorr/vim-bufkill'

" Add more text objects
Plug 'wellle/targets.vim'

" ttags_vim dependency
Plug 'tomtom/tlib_vim'
Plug 'tomtom/ttags_vim'

let g:ttags_display = 'tlib'

" Show available tags
noremap <Leader>g. :TTags<cr>

" Show current buffer's tags
noremap <Leader>g% :call ttags#List(0, "*", "", ".")<cr>

" Show tags matching the word under cursor
noremap <Leader>g# :call ttags#List(0, "*", tlib#rx#Escape(expand("<cword>")))<cr>

" Show tags with a prefix matching the word under cursor
noremap <Leader>g* :call ttags#List(0, "*", tlib#rx#Escape(expand("<cword>")) .".*")<cr>

" Show tags matching the word under cursor (search also in |g:tlib_tags_extra|)
noremap <Leader>g? :call ttags#List(1, "*", tlib#rx#Escape(expand("<cword>")))<cr>

" Html plugin
Plug 'rstacruz/sparkup'

" Rainbow parenthesis
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

let g:rainbow_conf = {
    \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \    'operators': '_,_',
    \    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \    'separately': {
    \        '*': {},
    \        'tex': {
    \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \        },
    \        'lisp': {
    \            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \        },
    \        'vim': {
    \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \        },
    \    }
    \}

" Multiline searching
Plug 'wincent/ferret'
let g:FerretMap=0

" Nedded by vim-notes
Plug 'xolox/vim-misc'
" Take notes in vim
Plug 'xolox/vim-notes'
let g:notes_directories = ['~/.notes']

" Check particular type of word
Plug 'reedes/vim-wordy'
noremap <silent> <F8> :<C-u>NextWordy<cr>
xnoremap <silent> <F8> :<C-u>NextWordy<cr>
inoremap <silent> <F8> <C-o>:NextWordy<cr>

Plug 'reedes/vim-litecorrect'
nnoremap <C-s> [s1z=<c-o>
inoremap <C-s> <c-g>u<Esc>[s1z=`]A<c-g>u

" Pick html color
Plug 'DougBeney/pickachu'

" Octave syntax
Plug 'jvirtanen/vim-octave'

" Open filename:line
Plug 'kopischke/vim-fetch'

" Meson build support
Plug 'igankevich/mesonic'

" vim fugitive extension
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" Exheres syntax
Plug 'https://gitlab.exherbo.org/exherbo-misc/exheres-syntax'

" srcery colorscheme
" Plug 'roosta/srcery'
" let g:srcery_italic = 1
" let g:srcery_inverse_match_paren = 1

" Accent
Plug 'airblade/vim-accent'

" Pulse while search
Plug 'inside/vim-search-pulse'
nmap n n<Plug>Pulse
nmap N N<Plug>Pulse
nmap * *<Plug>Pulse
nmap # #<Plug>Pulse

" Improve registers
Plug 'junegunn/vim-peekaboo'

" Colorscheme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" Add git for version control
Plug 'mhinz/vim-signify'

" Highlight mathcing words
Plug 'RRethy/vim-illuminate'

call plug#end()

colorscheme challenger_deep
set background=dark
set termguicolors

" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" augroup OnSave
"     autocmd!
"     " Autoformat code using neoformat and trim whitespaces
"     " autocmd BufWritePre * Neoformat
" augroup END

function! EnterWriterMode()
    call pencil#init({'wrap': 'hard', 'autoformat': 0})
    Limelight
    " execute `Goyo` if it's not already active
    if !exists('#goyo')
        Goyo
    endif
    call litecorrect#init()
    setlocal spell
    setlocal wrap
    set noshowmode
    set noshowcmd
    set nocursorcolumn
    set scrolloff=999
    set list lcs=tab:+.
    " Underline spelling errors in red
    hi clear SpellBad
    hi SpellBad cterm=underline ctermfg=red
    hi clear SpellCap
    hi SpellCap cterm=underline ctermfg=blue
    " Underline localization errors in green.
    hi clear SpellLocal
    hi SpellCap cterm=underline ctermfg=green
    let g:ncm2_look_enabled = 1
endfunction

function! s:LeaveWriterMode()
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
    let g:ncm2_look_enabled = 0
    " set background=dark
endfunction

autocmd! User GoyoLeave nested call <SID>LeaveWriterMode()

