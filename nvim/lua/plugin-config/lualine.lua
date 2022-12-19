local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("没有找到 lualine")
  return
end

local navic = require("nvim-navic")

lualine.setup({
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '|', right = '|' },
    globalstatus = true,
  },
  extensions = { "nvim-tree" },
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { '|', '/', '-', '\\' },
      },
    },
    lualine_x = {
      {
        "fileformat",
        symbols = {
          unix = '', -- LF
          dos = '', -- CRLF
          mac = '', -- CR
        },
      },
      "encoding",
      "filetype",
    },
  },
})
