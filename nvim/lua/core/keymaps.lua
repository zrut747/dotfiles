-- leader
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

local opt = {
  silent = true,
}

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------
-- 使用 jk 退出 insert 模式
map("i", "jk", "<ESC>", opt)

-- 保存退出
map("n", "<leader>qq", ":wqa<CR>", opt)

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>", opt)
map("n", "zo", ":foldopen<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)

-- SymbolsOutline
map("n", "<A-o>", ":Lspsaga outline<CR>", opt)
