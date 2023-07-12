-- 插件快捷键
local M = {}

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- lsp 回调函数快捷键设置
M.map = function(buffer)
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
  -- formatting
  map("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format", buffer = buffer })
end

return M
