
" Environment {
    " Basics {
        set nocompatible

        if !(has('win16') || has('win32') || has('win64'))
            set shell=/bin/sh
        endif
    " }

    " Windows compatibility {
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME,

            if has('multi_byte')
                set termencoding=cp850
                set encoding=utf-8
                setglobal fileencoding=utf-8
                set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
            endif
        endif
    " }

    " Bundle support {
        filetype on
        filetype off

        set runtimepath+=~/.vim/bundle/Vundle.vim

        call vundle#rc()
    " }
" }

" Bundles {
    " Dependencies {
        Bundle 'gmarik/vundle'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
    " }

    " General {
        Bundle 'scrooloose/nerdtree'
        Bundle 'tomasr/molokai'
        Bundle 'baskerville/bubblegum'
        Bundle 'tpope/vim-surround'
        Bundle 'kien/ctrlp.vim'
        Bundle 'matchit.zip'
        Bundle 'Lokaltog/vim-easymotion'
        Bundle 'tpope/vim-abolish'
        Bundle 'spf13/vim-autoclose'
    " }

    " General programming {
        Bundle 'tpope/vim-fugitive'
        Bundle 'tomtom/tcomment_vim'

        if executable('ctags')
            Bundle 'majutsushi/tagbar'
        endif
    " }

    " Snippets / Completion
        Bundle 'garbas/vim-snipmate'
        Bundle 'honza/vim-snippets'
        Bundle 'ervandew/supertab'
    " }

    " Perl {
    " }
" }

" General {
    filetype plugin indent on
    syntax on

    set mouse=a
    set mousehide

    scriptencoding utf-8

    if has('x') && has('gui')
        set clipboard=unnamedplus
    elseif has('gui')
        set clipboard=unnamed
    endif

    set shortmess+=filmnrxoOtT
    set viewoptions=folds,options,cursor,unix,slash
    set virtualedit=onemore
    set history=512
    set hidden

    if has('persistent_undo')
        set undofile
        set undodir=~/.vim/undo
        set undolevels=512
        set undoreload=8192
    endif
" }

" Vim UI {
    set background=dark

    if filereadable(expand('~/.vim/bundle/molokai/colors/molokai.vim'))
        let g:molokai_original=0
        let g:rehash256=1

        colorscheme molokai
    endif

    " Display the current mode
    set showmode

    " Highlight current line
    set cursorline

    if has('cmdline_info')
        set ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
        set showcmd
    endif

    if has('statusline')
        set laststatus=2

        set statusline=%<%f\
        set statusline+=%w%h%m%r
        set statusline+=%{fugitive#statusline()}
        set statusline+=\ [%{&ff}/%Y]
        set statusline+=\ [%{getcwd()}]
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%
    endif

    set backspace=indent,eol,start
    set linespace=0
    set number
    set showmatch

    set incsearch
    set hlsearch
    set ignorecase
    set smartcase

    set winminheight=0

    set wildmenu
    set wildmode=list:longest,full

    set whichwrap=b,s,h,l,<,>,[,]

    set scrolljump=5
    set scrolloff=3

    set foldenable

    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
" }

" Formatting {
    set nowrap
    set autoindent
    set shiftwidth=4
    set expandtab
    set tabstop=4
    set softtabstop=4
    set nojoinspaces
    set splitright
    set splitbelow

    set pastetoggle=<F12>

    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
" }

" Key mappings {
    let mapleader=','

    noremap j gj
    noremap k gk

    nnoremap Y y$

    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Change working directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection
    vnoremap . :normal .<CR>

    " Force write with sudo
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    cnoremap %% <C-R>=expand('%:h').'/'<CR>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabedit %%

    " Adjust viewports to the same size
    map <leader>= <C-w>=

    " Display all lines with keyword under cursor and ask which one to jump to
    nmap <leader>ff [I:let nr=input('Which one: ')<BAR>exe 'normal '.nr.'[\t'<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH
" }

" Plugins {
    " Plugin : nerdtree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    " }
" }

" GUI settings {
    if has('gui_running')
        set guioptions-=m
        set guioptions-=T
        set guioptions-=l
        set guioptions-=r

        set guioptions+=c

        set lines=40

        if has('gui_gtk2')
            set guifont=Inconsolata\ Regular\ 12,Monospace\ Regular\ 10
        elseif has('gui_mac')
            set guifont=Inconsolata\ Regular:h12,Monospace\ Regular:h10
        elseif has('gui_win32')
            set guifont=Inconsolata:h12,Monospace:h10
        endif

        if has('gui_macvim')
            set transparency=5
        endif
    else
        if &term=='xterm' || &term=='screen'
            set t_Co=256
        endif
    endif
" }

" Functions {
    " Strip trailing whitespace {
        function! StripTrailingWhitespace()

            " Saving current search item
            let _s=@/

            " Saving current cursor position
            let l=line('.')
            let c=col('.')

            " Strip'em
            %s/\s\+$//e

            " Restore the last search item
            let @/=_s

            " Restore last cursor position
            call cursor(l, c)
        endfunction
    " }

    " Execute shell command {
        function! s:RunShellCommand(cmdline)
            botright new

            setlocal buftype=nofile
            setlocal bufhidden=delete
            setlocal nobuflisted
            setlocal noswapfile
            setlocal nowrap
            setlocal filetype=shell
            setlocal syntax=shell

            call setline(1, a:cmdline)

            execute 'silent $read !'.escape(a:cmdline, '%#')

            setlocal nomodifiable
        endfunction

        command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " }
" }
