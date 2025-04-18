-- 诊断配置
local icons = require("nvim-web-devicons")
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.get_icon("DiagnosticError"),
      [vim.diagnostic.severity.WARN] = icons.get_icon("DiagnosticWarn"),
      [vim.diagnostic.severity.INFO] = icons.get_icon("DiagnosticInfo"),
      [vim.diagnostic.severity.HINT] = icons.get_icon("DiagnosticHint"),
    },
  },
  virtual_lines = {
    current_line = true,
  },
})
-- lsp配置
vim.lsp.enable({
  -- 前端
  "volar",
  -- python
  "ruff",
  "pyright",
  -- lua
  "luals",
  -- typst
  "prettypst",
})
