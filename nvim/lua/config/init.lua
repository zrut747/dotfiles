local M = {}

M.setup = function()
  require("config.options")
  require("config.keymaps")

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  local u = require("util")
  local mirror = u.github_mirror()
  if not vim.loop.fs_stat(lazypath) then
    vim.notify("使用github镜像：" .. mirror)
    vim.notify("正在安装lazy.nvim，请稍后...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      string.format("%s/folke/lazy.nvim.git", mirror),
      "--branch=stable", -- latest stable release
      lazypath,
    })
    vim.notify("lazy.nvim 安装完毕")
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup("plugins", {
    git = {
      url_format = mirror .. '/%s.git',
    }
  })

  vim.cmd('colorscheme catppuccin')
  require("config.autocmds")
end

return M
