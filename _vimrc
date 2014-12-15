"set shell=c:/cygwin/bin/bash
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
"set termencoding=cp936
"set fileencoding=cp936
set fileencoding=utf-8
setglobal fileencoding=utf-8 
set ambiwidth=double
set go=
set nu 

set grepprg=grep\ -nri 
"高亮当前行
set cursorline
"hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow
"hi CursorLine  cterm=bold ctermbg=black ctermfg=green guibg=green guifg=yellow

" Following three lines remove the auto copy function from VIM
set guioptions-=aA

"let yank use windows clipboard
set clipboard=unnamed


if has("win32")
  let $VIMFILES = $VIM.'/vimfiles'
else
  let $VIMFILES = $HOME.'/.vim'
endif

if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

"------------------------------
" |wildignore| influences the result of |expand()|, |globpath()| and
"|glob()| which many plugins use to find stuff on the system (e.g. VCS related
"plugins look for .git/, .hg/,... some other plugins look for external *.exe
"tools on Windows).
if(g:iswindows)
	set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
endif

"使用windows的vim避免按键冲突
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set langmenu=en_US
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"language messages none

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"设置leader键
let mapleader=","
"设置tab转换为空格
set sw=4
set ts=4

"自动缩进
set autoindent
set cindent

" 状态栏
set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

" 获取当前路径，将$HOME转化为~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\



let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

"vundle {{
set nocompatible "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
filetype off                  " required

" set the runtime path to include Vundle and initialize
"let iCanHazVundle=1
set rtp+=~/.vim/bundle/Vundle.vim/
let path='$VIMFILES/bundle/'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fs111/pydoc.vim'

" Better file browser
Plugin 'scrooloose/nerdtree'
" Code commenter
Plugin 'scrooloose/nerdcommenter'
" Class/module browser
Plugin 'majutsushi/tagbar'
"" Code and files fuzzy finder
Plugin 'kien/ctrlp.vim'
"" Extension to ctrlp, for fuzzy command finder
Plugin 'fisadev/vim-ctrlp-cmdpalette'
"" Airline
Plugin 'bling/vim-airline'
"Plugin 'bling/vim-bufferline'
"" Terminal Vim with 256 colors colorscheme
Plugin 'fisadev/fisa-vim-colorscheme'
"" Consoles as buffers
"Plugin 'rosenfeld/conque-term'
"" Surround
Plugin 'tpope/vim-surround'
"" Autoclose
Plugin 'Townk/vim-autoclose'
"" Indent text object
Plugin 'michaeljsmith/vim-indent-object'
"" Python mode (indentation, doc, refactor, lints, code checking, motion and
"" operators, highlighting, run and ipdb breakpoints)
Plugin 'klen/python-mode'
"" Better autocompletion
Plugin 'Shougo/neocomplcache.vim'
"" Snippets manager (SnipMate), dependencies, and snippets repo
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
" Track the engine.
Plugin 'SirVer/ultisnips'
"python dictionary
Plugin 'Pydiction'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'Rip-Rip/clang_complete'
"
"" Automatically sort python imports
"Plugin 'fisadev/vim-isort'
"" Window chooser
Plugin 't9md/vim-choosewin'
"" Python and other languages code checker
" Plugin 'scrooloose/syntastic'
"" Search results counter
Plugin 'IndexedSearch'
"" XML/HTML tags navigation
Plugin 'matchit.zip'
"" Gvim colorscheme
Plugin 'Wombat'
" Yank history navigation
"Plugin 'YankRing.vim'
"cmd line auto complete 
Plugin 'CmdlineComplete'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
"zen coding for html
"Plugin 'mattn/emmet-vim'
"Plugin 'autoload_cscope.vim'

Plugin 'Lokaltog/vim-easymotion'
"Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-endwise'
Plugin 'haya14busa/incsearch.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'tommcdo/vim-exchange'
Plugin 'justinmk/vim-ipmotion'
Plugin 'argtextobj.vim'
"Plugin 'VisIncr'
"must install python 3.2
Plugin 'kien/rainbow_parentheses.vim'

Plugin 'mhinz/vim-startify'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"vundle }}
" ============================================================================
" Install plugins the first time vim runs

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" Detect filetype
autocmd BufNewFile,BufRead *.h,*.cpp,*.c set filetype=cpp

autocmd BufNewFile,BufRead *.py set filetype=python

autocmd BufRead,BufNewFile *.java set filetype=java | set syntax=java
"octopress
autocmd BufNewFile,BufRead *.markdown,*.md,*.textile set filetype=octopress

"去掉自动注释
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType c,cpp,h,cc,hpp setl fdm=syntax | setl fen 

autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType c,cpp,h,cc,hpp map <buffer> <M-o> :A<CR>



"去空行
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件
nnoremap <C-F2> :vert diffsplit
"新建标签
map <M-F2> :tabnew<CR>

"设置文本格式
set fileformats=dos,unix,mac

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=2
" 为C程序提供自动缩进
set smartindent
set showcmd " 输入的命令显示出来，看的清楚些

" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
"set completeopt=preview,menu
set completeopt=menu

"taglist
"let Tlist_Auto_Open = 1
nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行

"不生成备份文件
set nobackup
set noswapfile


"搜索时大小写
set ignorecase smartcase


"设定文件浏览器目录为当前目录
set bsdir=buffer
set autochdir

" 设置配色方案
"colorscheme wombat
"colorscheme murphy
colorscheme solarized

"--------启用代码折叠，用空格键来开关折叠   
"set foldmethod=manual " 手动折叠
set foldenable    " 打开代码折叠  
set foldmethod=syntax        " 选择代码折叠类型  
" python 设置
autocmd FileType python setlocal foldmethod=indent
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>   

"默认展开所有代码
set foldlevel=99

"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt+=longest
 
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 在父目录找tags
"""""""""""""设置开启ctags"""""""""""""     
set tags=tags;
map <F4> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>  


"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
exec "! %<"
elseif &filetype == 'cpp'
exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"

" exec "! ./%<" 处理好目录

exec "! %<"
elseif &filetype == 'java'
exec "!javac %"
exec "!java %<"
elseif &filetype == 'sh'
:!./%
endif
endfunc
"C,C++的调试
"map <F9> :call Rungdb()<CR>
"func! Rungdb()
"exec "w"
"exec "!g++ % -g -o %<"
"exec "!gdb %<.exe"
"endfunc

"设置字体
set guifont=Consolas:h14 " 设置字体

"增加%好的匹配
set mps+=<:>

au FileType c,cpp set mps+==:;

"cscope插件配置
set cscopequickfix=s-,c-,d-,t-,e-

"tabbar配置 在tab间使用alt+num快速切换
function! TabPos_ActivateBuffer(num)  
    let s:count = a:num   
    exe "tabfirst"  
    exe "tabnext" s:count    
endfunction  
  
function! TabPos_Initialize()  
    for i in range(1, 9)   
        exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"  
    endfor  
    exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>"  
endfunction  
  
autocmd VimEnter * call TabPos_Initialize()  


"vim打开时最大化
au GUIENter * simalt ~x

"设置path
set path=.,E:\Program_Files\Microsoft_Visual_Studio_8\VC\PlatformSDK\Include,,

syntax on
syntax enable
"vimexplorer
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
au BufRead,BufWrite *.txt setlocal ft=txt
"let g:VEConf_systemEncoding='cp936'
let g:VEConf_browseHistory=20
let g:VEConf_showFolderStatus=0

"NERDTree
map <F11> :NERDTreeToggle<CR>

"surround
autocmd FileType markdown,md,octopress let b:surround_97 = " ``` "
"

"tabbar
nnoremap <silent> <F10> :TagbarToggle<CR>

"Pydoc
let g:pydoc_cmd = 'python -m pydoc'

"python mode
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_syntax = 1
let g:pymode = 1
"clang complete
"autocmd FileType cpp,h,c,cc,hpp  let g:neocomplcache_disable_auto_complete=1
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_complete_patterns=1
let g:clang_jumpto_back_key="<C-T>"
let g:clang_jumpto_declaration_key="<C-P>"
let g:clang_user_options = "-IC:/LLVM/lib/clang/3.4/include"
let g:clang_library_path = "C:/LLVM/bin"
"neocomplete---------
"work with clang_complete
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objcpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 20
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 3
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_min_keyword_length = 2


" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" resolve conflict with *endwisw* pugin
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
inoremap <expr><C-u>  neocomplcache$smart_close_popup()."\<C-u>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

"------------------------------------------

" don't use linter, we use syntastic for that
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" open definitions on same window, and custom mappings for definitions and
" occurrences
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = ',e'
nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
nmap ,o :RopeFindOccurrences<CR>
"--------------------
" Airline ------------------------------
let g:airline#extensions#bufferline#enabled = 1
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"------
"
" Syntastic ------------------------------

" show list of errors and warnings on the current file
"nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 0
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
let g:syntastic_check_on_wq = 0
"--------------

"ultisnipsedit
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"
let g:UltiSnipsUsePythonVersion = 2

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"easygrep
let g:EasyGrepExtraWarnings=0


"choosewin
nmap - <Plug>(choosewin)
"----------
"pydiction
let g:pydiction_location = '$VIMFILE/bundle/pydiction/complete-dict'

"startify
let g:startify_bookmarks = [ '$VIM/_vimrc' ]

"easymotion------------------------
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap <Leader>s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader><Leader>s <Plug>(easymotion-s2)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

"ctrlp---
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_by_filename = 0
let g:ctrlp_custom_ignore = {
\ 'file': '\v(\.cpp|\.h|\.hh|\.cxx)@<!$'
\ }
let g:ctrlp_mruf_include = '\.py$\|\.rb$|\.c$|\.h|\.cpp$|\.java$|\.cc$'
"----

"zen emmet------
let g:user_emmet_install_global = 0
"autocmd FileType html,css,markdown,octopress,md EmmetInstall
"-------

"rainbow_parentheses --
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter *.h,*.cpp,*.c,*.java,*.py,*.cc,*.hpp  RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"---


nmap <Leader><Leader>p :!devenv E:\ue\ueddt\src\core\uefacade\uefacade.sln /build Release<CR>

"CTAG and cscope 
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

