-- 插件快捷键
local M = {}

-- lsp 回调函数快捷键设置
M.mapLSP = function(mapbuf)
  -- rename
  -- mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
  -- code_action
  -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
  -- code_definition
  mapbuf("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto Definition" })
  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto Declaration" })
  -- hover
  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover" })
  -- diagnostic
  mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
  mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
  -- reference
  mapbuf("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
  -- formatting
  mapbuf("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format Document" })
end

return M
