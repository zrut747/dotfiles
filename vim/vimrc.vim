" 代码高亮
" 代码高亮
syntax on

" 使用jj退出insert模式
inoremap jj <ESC>

" 移动
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap dH d^
nnoremap dL d$
nnoremap <C-D> 10j
nnoremap <C-U> 10k

" 编码
set encoding=utf-8

" 缩进
set ts=4
set sts=4
set sw=4
set expandtab
if has("autocmd")
    au BufNewFile,BufRead *.html,*.js,*.jsx,*.ts,*.tsx,*.vue set ts=2
    au BufNewFile,BufRead *.html,*.js,*.jsx,*.ts,*.tsx,*.vue set sts=2
    au BufNewFile,BufRead *.html,*.js,*.jsx,*.ts,*.tsx,*.vue set sw=2
    au BufNewFile,BufRead *.html,*.js,*.jsx,*.ts,*.tsx,*.vue set expandtab
endif

" leader键绑定
let mapleader = ";"

" 标签页切换
nnoremap <leader>th :tabp<CR>
nnoremap <leader>tl :tabn<CR>

" 分屏操作
nnoremap <leader>sh :split<CR>
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sc :close<CR>


" IDEA操作 "
" 重命名元素
nnoremap <leader>re :action RenameElement<CR>
" 显示方法参数
nnoremap <leader>pi :action ParameterInfo<CR>
" 查看方法内使用了该变量的引用信息
nnoremap <leader>su :action ShowUsages<CR>
" Build
nnoremap <leader>bd :action CompileDirty<CR>
" Run
nnoremap <leader>rr :action Run<CR>
" Debug
nnoremap <leader>rd :action Debug<CR>
" Stop
nnoremap <leader>sp :action Stop<CR>
