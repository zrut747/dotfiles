local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------
-- 使用 jk 退出 insert 模式
map("i", "jk", "<ESC>")

-- 保存退出
map("n", "<leader>qq", ":wqa<CR>")

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>")
map("n", "zo", ":foldopen<CR>")

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>")
map("n", "<C-l>", ":BufferLineCycleNext<CR>")
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>")
map("n", "<leader>bl", ":BufferLineCloseRight<CR>")
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>")

-- 注释
map({ "n", "v" }, "<C-_>", "gcc", { remap = true })

-------------------------------------------------------------------
-- LSP
require("util").on_attach(function(_, buffer)
  -- rename
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename", buffer = buffer })
  -- code_action
  -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action", buffer = buffer })
  -- code_definition
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition", buffer = buffer })
  -- hover
  map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover", buffer = buffer })
  -- diagnostic
  map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic", buffer = buffer })
  map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic", buffer = buffer })
  -- reference
  map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References", buffer = buffer })
end)
-- outline
map("n", "<A-o>", "<cmd>Lspsaga outline<cr>", { desc = "Lspsaga Outline" })
