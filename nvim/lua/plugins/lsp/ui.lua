-- 自定义图标
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

local signs = require("config").icons.diagnostics
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("lspsaga").setup({})
