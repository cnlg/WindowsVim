source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

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
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
map <silent> <F11> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
imap <silent> <F11> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
"Windows插件安装需要设置
let &shellslash=0

"设置文件的代码形式 utf8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
 
"vim的菜单乱码解决
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
 
"vim提示信息乱码的解决
language messages zh_CN.utf-8

" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI 

" 不让vim发出讨厌的滴滴声
set noerrorbells

"打开文件识别
filetype on
filetype plugin indent on

"设置主题颜色
colorscheme desert

"set helplang=cn		"设置中文帮助
set history=500		"保留历史记录

"字体设置
"set guifont=Monaco:h10	"设置字体为Monaco，大小10
"set guifont=Courier_New:h12 ":cANSI   " 设置字体 

if has("gui_gtk2")                              
    set guifont=DejaVu\ Sans\ Mono\ 11                              
elseif has("gui_macvim")                              
    set guifont=DejaVu_Sans_Mono:h11                              
elseif has("gui_win32")                              
    "set guifont=DejaVu_Sans_Mono:h11
    set guifont=Courier_New:h12 ":cANSI   " 设置字体  
end

au BufNewFile,BufRead *.py,*.pyw setf python

"行内替换
"set gdefault

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

set nu  		"设置显示行号
set relativenumber
set backspace=2 	"设置退格键可用
"set wrap 		"设置自动换行
"set nowrap 		"设置不自动换行
set linebreak 		"整词换行，与自动换行搭配使用
"set list 		"显示制表符
set autochdir 		"自动设置当前目录为正在编辑的目录
set hidden 		"自动隐藏没有保存的缓冲区，切换buffer时不给出保存当前buffer的提示
set scrolloff=5 	"在光标接近底端或顶端时，自动下滚或上滚
set showtabline=2 	"设置显是显示标签栏
set autoread 		"设置当文件在外部被修改，自动更新该文件
set mouse=a 		"设置在任何模式下鼠标都可用
"set cursorcolumn       "启用光标列
set cursorline	        "启用光标行
set guicursor+=a:blinkon0   "设置光标不闪烁
set fdm=indent "
set nofoldenable        "禁止折叠
"注释改成绿色
"hi Comment ctermfg=2 guifg=green  
set showcmd             "输入的命令显示出来，看的清楚些  
set noswapfile          "不生成.swp文件
syntax on     "打开语法高亮

"禁止生成临时文件
set noundofile
set nobackup
set noswapfile

"去除声音
set noeb
set vb t_vb= "关闭声音
au GuiEnter * set t_vb= "关闭闪屏


"可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
"set selection=exclusive
"set selectmode=mouse,key

 
"===========================
"查找/替换相关的设置
"===========================
set hlsearch "高亮显示查找结果
set incsearch "增量查找
 
"===========================
"状态栏的设置
"===========================
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "显示文件名：总行数，总的字符数
set ruler "在编辑过程中，在右下角显示光标位置的状态行
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限 
 

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no

"leader映射为逗号“，
let mapleader = "," 

" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>


" 为C程序提供自动缩进
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
"function! ClosePair(char)
"    if getline('.')[col('.') - 1] == a:char
"        return "\<Right>"
"    else
"        return a:char
"  endif
"endfunction

"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

"set autoindent                       "vim使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进）
set cindent                             "（cindent是特别针对 C语言语法自动缩进）
set tabstop=4                        "设置tab键为4个空格，
set shiftwidth =4                   "设置当行之间交错时使用4个空格     
set expandtab
set smartindent                    "依据上面的对齐格式，智能的选择对齐方式，对于类似C语言编写上有用   
set softtabstop=4                  "方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格

if has("autocmd")
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
endif

" 括号自动补全
inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
"inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O

"定义CompileRun函数，用来调用编译和运行  
func CompileRun()  
exec "w"  
  
if &filetype == 'c'  
exec "!gcc -Wall -enable-auto-import % -g -o %<.exe"  
  
elseif &filetype == 'cpp'  
exec "!g++ -Wall -enable-auto-import % -g -o %<.exe"  
  
elseif &filetype == 'java'  
exec "!javac %"  
endif  
endfunc  
"结束定义ComplieRun  
  
"定义Run函数  
func Run()  
if &filetype == 'c' || &filetype == 'cpp'  
exec "!%<.exe"  
elseif &filetype == 'java'  
exec "!java %<"  
endif  
endfunc  
  
"定义Debug函数，用来调试程序  
func Debug()  
exec "w"  
  
if &filetype == 'c'  
exec "!gcc % -g -o %<.exe"  
exec "!gdb %<.exe"  
elseif &filetype == 'cpp'  
exec "!g++ % -g -o %<.exe"  
exec "!gdb %<.exe"  
elseif &filetype == 'java'  
exec "!javac %"  
exec "!jdb %<"  
endif  
endfunc  
  
"设置程序的运行和调试的快捷键F5和Ctrl-F5  
map <F5> :call CompileRun()<CR>  
map <F6> :call Run()<CR>  
map <C-F5> :call Debug()<CR>


"插件管理
"set rtp+=$VIM\vimfiles\bundle\Vundle.vim\
"call vundle#begin('~/some/path/here')
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin()
"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"my bundle plugin

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
"Plugin 'minibufexplorerpp'
"Plugin 'taglist.vim'          "使用插件Tagbar代替
Plugin 'quickfixstatus.vim'   
Plugin 'grep.vim'             "搜索字符串
Plugin 'a.vim'                ".c,.h文件切换
"Plugin 'bling/vim-airline'    "美化状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'txt.vim'
Plugin 'Shougo/neocomplete.vim'
"Plugin 'Yggdroot/indentLine'
Plugin 'wesleyche/SrcExpl'  "增强源码显示功能
Plugin 'terryma/vim-multiple-cursors'
Plugin 'cpp.vim'
Plugin 'luochen1990/rainbow'
Plugin 'lua.vim'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'xolox/vim-misc'
Plugin 'python.vim'


call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lua.vim 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lua_complete_omni = 1

" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile * setfiletype txt

" the hightline *.lua.txt
au BufNewFile,BufRead *.lua.txt set filetype=lua

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree.vim 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"插件快捷键设置
"autocmd vimenter * NERDTree
"快捷键
map <F2> :NERDTreeToggle<CR>
imap <F2> :NERDTreeToggle<CR>
"显示增强
let NERDChristmasTree=1
"自动调整焦点
let NERDTreeAutoCenter=1
"鼠标模式:目录单击,文件双击
let NERDTreeMouseMode=2
"打开文件后自动关闭
let NERDTreeQuitOnOpen=0
"显示文件
let NERDTreeShowFiles=1
"显示隐藏文件
let NERDTreeShowHidden=0
"高亮显示当前文件或目录
let NERDTreeHightCursorline=1
"显示行号
let NERDTreeShowLineNumbers=1
"窗口位置
let NERDTreeWinPos='left'
"窗口宽度
let NERDTreeWinSize=31
"不显示'Bookmarks' label 'Press ? for help'
let NERDTreeMinimalUI= 0 
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 设置当文件被改动时自动载入
" set autoread

"NERD_commenter设定注释
map <F9> <leader>cc
map <F10> <leader>cu

nnoremap <silent> <F4> :Grep<CR>
imap <silent> <F4> :Grep<CR>
set laststatus=2  "状态栏设置

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"窗口操作的快捷键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap wv     <C-w>v        "垂直分割当前窗口
nmap wc     <C-w>c        "关闭当前窗口
nmap ws     <C-w>s        "水平分割当前窗口

nmap    w=  :resize +3<CR>
nmap    w-  :resize -3<CR>
nmap    w,  :vertical resize -3<CR>
nmap    w.  :vertical resize +3<CR>

"""""按ctrl+G键自动缩进美化代码"""""
noremap <C-G> <Esc>gg=G<CR>
inoremap <C-G> <C-O> <Esc>gg=G<CR>

"切换窗口
nnoremap wj <C-W><C-J>
nnoremap wk <C-W><C-K>
nnoremap wl <C-W><C-L>
nnoremap wh <C-W><C-H>

"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

"新建标签
:map <F8> <Esc>:tabnew<CR>

"映射Alt-0_9快捷键快速选择标签
for temp in [0,1,2,3,4,5,6,7,8,9]
	exe 'map <A-' . temp . '> ' . temp . 'gt'
endfor


"normal & insert mode
"Alt + k ： 上移当前行
"Alt + j ： 下移当前行
"visual mode
"Alt + k ：上移当前行或者选中行
"Alt + j ： 下移当前行或者选中行

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <F7> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
"imap <F7> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
"map <F7> :!ctags -R <CR><CR>
map <F7> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>
imap <F7> <ESC>:!ctags -R <CR><CR>
set tags=tags;
set autochdir


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"默认打开Taglist 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_WinWidth=25
"let Tlist_Show_One_File=1   "不同时显示多个文件的tag，只显示当前文件的
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Sort_Type = "name"    " 按照名称排序  
"let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
"let Tlist_Compart_Format = 1    " 压缩方式  
"let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
"let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
"let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件
"nmap <silent> <F6> :Tlist<CR>  "映射快捷键F6，开启/关闭窗口

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"a.vim,头文件和源文件之间相互切换
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F12> :A<CR>
imap <silent> <F12> :A<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"minibufexplorerpp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:miniBufExplMapWindowNavVim = 1   "按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
"let g:miniBufExplMapWindowNavArrows = 1  "按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
"let g:miniBufExplMapCTabSwitchBufs = 1   "启用以下两个功能：Ctrl+tab移到下一个窗口
"let g:miniBufExplModSelTarget = 1  "不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer
"map <F9> :MBEbp<CR>
"map <F10> :MBEbn<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Tagbar.vim,头文件和源文件之间相互切换
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <Leader>tb :TagbarToggle<CR>        "快捷键设置
let g:tagbar_ctags_bin='ctags'            "ctags程序的路径
let g:tagbar_width=30                   "窗口宽度的设置
map <F3> :Tagbar<CR>
imap <F3> :Tagbar<CR>
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()     "如果是c语言的程序的话，tagbar自动开启

"if has(‘gui_running’) && has(“win32″)
"    map <F11> :call libcallnr(“gvimfullscreen.dll”, “ToggleFullScreen”, 0)<CR>
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"OmniComplete 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set completeopt=menu,menuone  
"let OmniCpp_MayCompleteDot=1    "  打开  . 操作符
"let OmniCpp_MayCompleteArrow=1  "打开 -> 操作符
"let OmniCpp_MayCompleteScope=1  "打开 :: 操作符
"let OmniCpp_NamespaceSearch=1   "打开命名空间
"let OmniCpp_GlobalScopeSearch=1  
"let OmniCpp_DefaultNamespace=["std"]  
"let OmniCpp_ShowPrototypeInAbbr=1  "打开显示函数原型
"let OmniCpp_SelectFirstItem = 2 "自动弹出时自动跳至第一个
"set tags=tags;

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe 功能  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"leader映射为逗号“，”
"let mapleader = "," 
"配置默认的ycm_extra_conf.py
"let g:ycm_global_ycm_extra_conf = 'C:\Program Files (x86)\Vim\.ycm_extra_conf.py'
"按gb 会跳转到定义
"nnoremap <silent> gb :YcmCompleter GoToDefinitionElseDeclaration<CR>  
"nnoremap <silent> gl :YcmCompleter GoglToDeclaration<CR>
"nnoremap <silent> gf :YcmCompleter GoToDefinition<CR>
"nnoremap <silent> gb :YcmCompleter GoToDefinitionElseDeclaration<CR>
 
"打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_confirm_extra_conf=0   
"使用ctags生成的tags文件
"let g:ycm_collect_identifiers_from_tag_files = 1 
"map <F4> : YcmDiags<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"neocomplete. 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete_start_auto_complete = 1
let g:neocomplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"


" -----------------------------------------------------------------------------  
"  < indentLine 插件配置 >  
" -----------------------------------------------------------------------------  
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了  
" 在终端上会有屏幕刷新的问题，这个问题能解决有更好了  
" 开启/关闭对齐线  
"nmap <leader>il :IndentLinesToggle<CR>
"let g:indentLine_char = "┊"
"let g:indentLine_first_char = "┊"
"let g:indentLine_color_gui = '#A4E57E

" -----------------------------------------------------------------------------  
"  < SrcExpl 插件配置 >  
" -----------------------------------------------------------------------------  
" 增强源代码浏览，其功能就像Windows中的"Source Insight"  
"nmap <F7> :SrcExplToggle<CR>                "打开/闭浏览窗口 

" -----------------------------------------------------------------------------  
"  < vim-multiple-cursors 插件配置 >  
" -----------------------------------------------------------------------------  
set selection=inclusive
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


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

"美化状态栏"
""""""""""""""""""""""""""""""""""""""""""  
""" airline设置  
""""""""""""""""""""""""""""""""""""""""""  
set t_Co=256 " Enable status bar color
set laststatus=2
"在执行宏命令时，不进行显示重绘；在宏命令执行完成后，一次性重绘，以便提高性能。
set lazyredraw
"let g:airline_theme='luna'
"let g:airline_theme='simple'
"let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
" 关闭空白符检测  
let g:airline#extensions#whitespace#enabled= 0

" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = '>>'
" tabline中未激活buffer两端的分隔字符
let g:airline_left_alt_sep = '>'
let g:airline_right_sep = '<<'
let g:airline_right_alt_sep = '<'
let g:airline_symbols.branch = '|'
let g:airline_symbols.readonly = '|'
let g:airline_symbols.linenr = '|'


"设置切换Buffer快捷键"
nnoremap <C-L> :bn<CR>
nnoremap <C-H> :bp<CR>

" 映射<leader>num到num buffer
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>


inoremap jj <esc>
"inoremap jj <esc>f

"cpp-enhanced-highlight
"高亮类，成员函数，标准库和模板
"let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:cpp_concepts_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1
"let c_no_curly_error=1

""""""""""""""""""""""""""""""""""""""""""  
""" 括号颜色 
"""""""""""""""""""""""""""""""""""""""""" 
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
	\	'guifgs': ['green', 'darkorange3', 'seagreen3', 'yellow'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}
	
"取消高亮显示
map <C-k> :noh<CR>
imap <C-k> :noh<CR>

"normal & insert mode
"Alt + k ： 上移当前行
"Alt + j ： 下移当前行
"visual mode
"Alt + k ：上移当前行或者选中行
"Alt + j ： 下移当前行或者选中行

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"打开当前文件所在目录
function OpenFileLocation()  
    if ( expand("%") != "" )  
        execute "!start explorer /select, %"   
    else  
        execute "!start explorer /select, %:p:h"  
    endif  
endfunction  
  
map gb <ESC>:call OpenFileLocation()<CR>  

" Go to last file(s) if invoked without arguments.
"autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
"    \ call mkdir($HOME . "/.vim") |
"    \ endif |
"    \ execute "mksession! " . $HOME . "/.vim/Session.vim"
"
"autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
"    \ execute "source " . $HOME . "/.vim/Session.vim"


"注释改成绿色

highlight Comment ctermfg=green guifg=green

