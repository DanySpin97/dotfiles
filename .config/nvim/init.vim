set encoding=utf8

"Map the leader key to SPACE
let mapleader="\<SPACE>"
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set nosmarttab
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set noshowmode          " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
    set scrolloff=7       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
    set sidescrolloff=10   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.

set laststatus=2 " Always show status bar
set updatetime=500 " Let plugins show effects after 500ms, not 4s
set mouse-=a " Disable mouse click to go to position
" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert

set hidden
set history=100

" Set to auto read when a file is changed from the outside
set autoread

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500"

" Tell Vim which characters to show for expanded TABs,
" and end-of-lines.
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

set hlsearch            " Highlight search results.
set ignorecase          " Make searching case-insensitive
set smartcase           " ... unless the query has capital letters.
set incsearch           " Incremental search.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Disable swap and backup
set nobackup
set noswapfile
set nowb

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Remap comma to double dots
map , :

" Caps lock is now rebind to esc
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Reload config on savings
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" Ex command control
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Add cpp syntax for .tpp files
autocmd BufEnter *.tpp :setlocal filetype=cpp

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
        set nornu
        set number
    else
        set rnu
    endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" Resize windows
map + 20<C-W>+
map - 20<C-W>-
map < 20<C-W><
map > 20<C-W>>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

""" Terminal Mapping
tnoremap <Esc> <C-\><C-n>

" Remapping for switching windows when in terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Get terminal get input focus when switching to terminal window
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Easy switch between vims tab
nnoremap tc :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap tp :tabprev<CR>
nnoremap tn :tabnext<CR>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Move in wrapped lines instead of jumping over them
nnoremap j gj
nnoremap k gk

" Edit files with permission even after opened them
" (http://nvie.com/posts/how-i-boosted-my-vim/)
cmap w!! w !sudo tee % >/dev/null

" Current line highlithing
hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

set lazyredraw
syntax sync minlines=128

" vp doesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Autosave when focus is lost from window
" (disable it when using mirrors.vim)
au FocusLost * wa

" Send lines in range to hastebin.com and copy url to clipboard
command! -range -bar Haste <line1>,<line2>w !haste | xsel -b

" Neovim Terminal Colors
let g:terminal_color_0  = '#1d2021'
let g:terminal_color_1  = '#cc241d'
let g:terminal_color_2  = '#98971a'
let g:terminal_color_3  = '#d79921'
let g:terminal_color_4  = '#458588'
let g:terminal_color_5  = '#b16286'
let g:terminal_color_6  = '#689d6a'
let g:terminal_color_7  = '#a89984'
let g:terminal_color_8  = '#928374'
let g:terminal_color_9  = '#fb4934'
let g:terminal_color_10 = '#b8bb26'
let g:terminal_color_11 = '#fabd2f'
let g:terminal_color_12 = '#83a598'
let g:terminal_color_13 = '#d3869b'
let g:terminal_color_14 = '#8ec07c'
let g:terminal_color_15 = '#ebdbb2'

call plug#begin()

" UI plugins
Plug 'vim-airline/vim-airline'
Plug 'freeo/vim-kalisi'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'mbbill/undotree'
Plug 'tpope/vim-characterize'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lilydjwg/colorizer'
"Plug 'airblade/vim-gitgutter'

" File management
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zenbro/mirror.vim'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'dietsche/vim-lastplace'
Plug 'tpope/vim-eunuch'
Plug 'vim-scripts/quit-another-window'
Plug 'pbrisbin/vim-mkdir'

" Vim motion and bindings
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-smooth-scroll'
Plug 'reedes/vim-wheel'
Plug 'powerman/vim-plugin-viewdoc'
Plug 'bkad/CamelCaseMotion'
Plug 'matze/vim-move'
Plug 'sunaku/vim-shortcut'

" Cliboard management
Plug 'vim-scripts/YankRing.vim'

" Indenting and autocompletition
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'jiangmiao/auto-pairs'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-endwise'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sniphpets/sniphpets-phpunit'

" Ctags and language plugins
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'shawncplus/phpcomplete.vim'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'

" Terminal and make
Plug 'wvffle/vimterm'
Plug 'neomake/neomake'
Plug 'thinca/vim-quickrun'

" Writer plugins
Plug 'reedes/vim-pencil'
Plug 'rhysd/vim-grammarous'

" Time
Plug 'wakatime/vim-wakatime'

call plug#end()

filetype plugin indent on

" Remove 'Shortcut: not an editor command' error
runtime plugin/shortcut.vim

" Set theme
syntax enable
set background=dark

""" Gruvbox config
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_italic=1
colorscheme gruvbox
set termguicolors

"""" indentLine config
" Set color for indenting character
let g:indentLine_color_term = 241

" Set new indenting char
let g:indentLine_char = '┆'

" Disable concealing
let g:indentLine_concealcursor = ''

""" NerdTree config

" Close NerdTree if it is the onyl windows open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NerdTree with ctrl+n
Shortcut open nerdtree window
            \ map <leader>n :NERDTreeToggle<CR>

" Show hidden file
let NERDTreeShowHidden=1

" Ignore file
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

" Arrows
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Symbols
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

""" air-line config
let g:airline_powerline_fonts = 1

" Set kalisi theme
let g:airline_theme='gruvbox'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" testing rounded separators (extra-powerline-symbols):
let g:airline_right_sep = "\uE0B6"

" Set the CN (column number) symbol:
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep =  ""
let g:airline#extensions#tabline#left_alt_sep =  ""

let b:usemarks         = 1
let b:cb_jump_on_close = 1

""" Easymotion configuration
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Turn on case-insensitive feature
let g:EasyMotio2_smartcase = 1

" JK motions: Line motions
Shortcut easymotion lineforward
            \ map <Leader>l <Plug>(easymotion-lineforward)
Shortcut easymotion down
            \ map <Leader>j <Plug>(easymotion-j)
Shortcut easymotion upper
            \ map <Leader>k <Plug>(easymotion-k)
Shortcut easymotion linebackward
            \ map <Leader>h <Plug>(easymotion-linebackward)

Shortcut easymotion e
            \ map <Leader>e <Plug>(easymotion-e)
Shortcut easymotion b
            \ map <Leader>b <Plug>(easymotion-b)

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

" <Leader>f{char} to move to {char}
Shortcut easymotion f
            \ map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
Shortcut easymotion move on line
            \ map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
Shortcut easymotion w
            \ map  <Leader>w <Plug>(easymotion-w)

""" Git gutter config
" Always show column
"let g:gitgutter_sign_column_always=1
" Stop git gutter when there are 500+ modifications
let g:gitgutter_max_signs = 500

" Speed up gitgutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

""" Startify config
let g:startify_enable_unsafe = 0

""" FZF config
" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
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

" Call fzf
Shortcut search in files
            \ map <Leader>z :FZF<CR>
Shortcut search in tags
            \ map <Leader>t :BTags<CR>

""" Tagbar
Shortcut open tagbar window
            \ nmap <F8> :TagbarOpen fj<CR>

" Focus tag bar when showing
let g:tagbar_autofocus = 1

""" vim-smooth-scroll config
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>

""" Cpp enhanced sintax highligthing
" Highlighting of class scope
let g:cpp_class_scope_highlight = 1

" Hightlight template functions
let g:cpp_experimental_simple_template_highlight = 1

" Highlighting of library concepts
let g:cpp_concepts_highlight = 1

""" Neoformat config
" Add a mapping
Shortcut format current file
            \ nmap <Leader>R :Neoformat<CR>

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1

""" Mirrors.vim config
" Add a mapping for pushing to the server
Shortcut push file to server
            \ nmap <Leader>p :MirrorPush<CR>

""" vim-wheel config
let g:wheel#map#up   = '<m-y>'
let g:wheel#map#down = '<m-e>'

""" Vimterm config
Shortcut toggle vimterm window
            \ nnoremap <F7> :call vimterm#toggle() <CR>
tnoremap <F7> <C-\><C-n>:call vimterm#toggle() <CR>

""" Undotree config
" Keymap for undotree gui
Shortcut toggle undotree window
            \ nnoremap <F5> :UndotreeToggle<cr>

" Focus undotree when showing it
let g:undotree_SetFocusWhenToggle = 1

" Add persistent undo history between files
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

""" YangRink config
nnoremap <silent> <F6> :YRShow<CR>

" Increase window height
let g:yankring_window_height = 12

" Change keys for replacing
let g:yankring_replace_n_pkey = '<C-p>'
let g:yankring_replace_n_nkey = '<C-n>'

""" Quick windows close
Shortcut close left window
            \ nnoremap <C-q>h :Qh <CR>
Shortcut close down window
            \ nnoremap <C-q>j :Qj <CR>
Shortcut close upper window
            \ nnoremap <C-q>k :Qk <CR>
Shortcut close right window
            \ nnoremap <C-q>l :Ql <CR>

""" Neomake config
" Run Neomake on everywriting
autocmd! BufWritePost * Neomake

" Disable c/c++ makers as YCM already handle this
let g:neomake_cpp_enabled_makers = []
let g:neomake_c_enabled_makers = []

""" Guten tag config
let g:gutentag_enabled = 1

""" vim-better-whitespace config
" Enable stripping on save
autocmd BufEnter * EnableStripWhitespaceOnSave
" Whitespaces color
highlight ExtraWhitespace ctermbg=darkred guibg=darkred

""" CamelCaseMotion config
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

""" Vim pencil config
augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
augroup END

""" You complete me config
let g:ycm_global_ycm_extra_conf='~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_goto_buffer_command = 'vertical-split'

Shortcut go to declaration
            \ nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
Shortcut go to include
            \ nnoremap <leader>jh :YcmCompleter GoToInclude<CR>
Shortcut go to definition
            \ nnoremap <leader>jk :YcmCompleter GoToDefinition<CR>
Shortcut get type
            \ nnoremap <leader>jt :YcmCompleter GetType<CR>
Shortcut fix error
            \ nnoremap <leader>jf :YcmCompleter FixIt<CR>

" mak YCM compatmble with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""" Grammarous config
" Chack grammar only for comments
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
" Use system laguage tool
let g:grammarous#languagetool_cmd = 'languagetool'

Shortcut move to the next grammatic error
            \ nmap <leader>go <Plug>(grammarous-move-to-next-error)
Shortcut fix current grammatic error
            \ nmap <leader>gf <Plug>(grammarous-fixit)
Shortcut remove current grammatic error
            \ nmap <leader>gr <Plug>(grammarous-remove-error)

""" vim-shortcut config
Shortcut show shortcut menu and run chosen shortcut
            \ noremap <silent> <Leader><Leader> :Shortcuts<Return>

noremap <silent> <Leader> :Shortcuts<Return>
