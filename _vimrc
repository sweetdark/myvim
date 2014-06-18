"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set go=
set nu


set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set langmenu=en_US
let $LANG= 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set langmenu=none
language messages none

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

"自动缩进
set autoindent
set cindent

"设置tab转换为空格
set sw=4
set ts=4

filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4

filetype indent on

autocmd FileType c,cpp  setl fdm=syntax | setl fen 


"去空行
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件
nnoremap <C-F2> :vert diffsplit
"新建标签
map <M-F2> :tabnew<CR>
"列出当前目录文件
map <F3> :tabnew .<CR>
"打开树状文件目录
map <C-F3> \be

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
set showcmd " 输入的命令显示出来，看的清楚些

" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
"set completeopt=preview,menu
set completeopt=menu


"不生成备份文件
set nobackup

"搜索时大小写
set ignorecase smartcase

"在下一行插入
map <C-p> o<Esc>]p

set nobackup
set noswapfile

"设定文件浏览器目录为当前目录
set bsdir=buffer
set autochdir

" 设置配色方案
colorscheme murphy

set foldmethod=manual " 手动折叠
" python 设置
autocmd FileType python setlocal foldmethod=indent
"默认展开所有代码
set foldlevel=99

"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt+=longest
 
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 在父目录找tags
set tags=tags;/

set nocompatible "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限

"列出当前目录文件
map <F3> :tabnew .<CR>
"打开树状文件目录
map <C-F3> \be
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
map <F8> :call Rungdb()<CR>
func! Rungdb()
exec "w"
exec "!g++ % -g -o %<"
exec "!gdb %<.exe"
endfunc

"设置字体
set guifont=Consolas:h14 " 设置字体

"增加%好的匹配
set mps+=<:>

au FileType c,cpp set mps+==:;

"cscope插件配置
cs a E:\ue\ueddt\src\core.out
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

"vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': 'E:/vimwiki/',
			\'path_html': 'E:/vimwiki/html/'}]

if has("win32")
  let $VIMFILES = $VIM.'/vimfiles'
else
  let $VIMFILES = $HOME.'/.vim'
endif

let g:VEConf_systemEncoding = 'cp936'
let g:VEConf_browseHistory=20
let g:VEConf_win32Disks=["C:","D:","E:"]
"let g:VEConf_filePanelFilter = '*.txt\|*.ztx\|*.htm\|*.h\|*.cpp\|*.c\|*.dat'
au GUIEnter * simalt ~x
