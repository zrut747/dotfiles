-- leader
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

local opt = vim.opt
-- utf8
opt.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
opt.scrolloff = 8
opt.sidescrolloff = 8
-- 显示行号
opt.number = true
-- 高亮所在行
opt.cursorline = true
-- 显示左侧图标指示列
opt.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
opt.colorcolumn = "80"
-- 缩进2个空格等于一个Tab
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
-- >> << 时移动长度
opt.shiftwidth = 2
-- 空格替代tab
opt.expandtab = true
-- 新行对齐当前行
opt.autoindent = true
opt.smartindent = true
-- 搜索大小写不敏感，除非包含大写
opt.ignorecase = true
opt.smartcase = true
-- 搜索不要高亮
opt.hlsearch = false
-- 边输入边搜索
opt.incsearch = true
-- 当文件被外部程序修改时，自动加载
opt.autoread = true
-- 禁止折行
opt.wrap = false
-- 允许隐藏被修改过的buffer
opt.hidden = true
-- 禁止创建备份文件
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- smaller updatetime
opt.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
-- 遇到问题详见：https://github.com/nshen/learn-neovim-lua/issues/1
opt.timeoutlen = 500
-- split window 从下边和右边出现
opt.splitbelow = true
opt.splitright = true
-- 样式
opt.termguicolors = true
-- 是否显示不可见字符
opt.list = true
-- 不可见字符的显示
opt.listchars = { space = ".", tab = ">-" }
-- 配置代码折叠格式
opt.foldcolumn = "1"
opt.foldlevel = 99

-- 配置剪切板
opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank -i --crlf",
      ["*"] = "win32yank -i --crlf",
    },
    paste = {
      ["+"] = "win32yank -o --lf",
      ["*"] = "win32yank -o --lf",
    },
    cache_enabled = 0,
  }
end
