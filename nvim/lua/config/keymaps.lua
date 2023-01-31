-- leader
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

local opt = {
  noremap = true,
  silent = true,
}

-- 保存本地变量
local map = vim.api.nvim_set_keymap

--------------------------------------------------------------------
-- 使用 jk 退出 insert 模式
map("i", "jk", "<ESC>", opt)

-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- 保存退出
map("n", "<leader>qq", ":wqa<CR>", opt)

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>", opt)
map("n", "zo", ":foldopen<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- vim-bbye" 关闭当前 buffer
map("n", "<A-c>", ":Bdelete!<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)

-- SymbolsOutline
map("n", "<A-o>", ":Lspsaga outline<CR>", opt)

-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gcc", { noremap = false })

-- scratch 插件
map("n", "<M-C-o>", "<cmd>ScratchOpen<cr>", opt)
