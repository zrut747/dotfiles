local M = {}

local u = require("util")

local default = {
  colorscheme = function()
    vim.cmd("colorscheme catppuccin")
  end,
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
  },
}

M = u.merge(M, default)

M.setup = function()
  require("core.options")
  require("core.keymaps")
  require("core.autocmds")

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.notify("正在安装lazy.nvim，请稍后...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
    vim.notify("lazy.nvim 安装完毕")
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = {
      { import = "plugins" },
      { import = "plugins.mason" },
    },
  })

  if type(M.colorscheme) == "function" then
    M.colorscheme()
  else
    vim.cmd.colorscheme(M.colorscheme)
  end
end

return M
