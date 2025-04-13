local M = {}

local u = require("util")

local function get_default_config()
  return {
    colorscheme = function()
      vim.cmd("colorscheme catppuccin")
    end,
  }
end

local function setup_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.notify("正在安装lazy.nvim，请稍后...")
    local success = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
    if success then
      vim.notify("lazy.nvim 安装完毕")
    else
      vim.notify("lazy.nvim 安装失败", vim.log.levels.ERROR)
      return false
    end
  end
  vim.opt.rtp:prepend(lazypath)
  return true
end

M = u.merge(M, get_default_config())

M.setup = function()
  -- 基础配置
  require("core.options")
  require("core.keymaps")
  require("core.autocmds")

  -- 插件管理
  if not setup_lazy() then
    return
  end

  -- 加载插件配置
  require("lazy").setup({
    spec = {
      { import = "plugins" },
      { import = "plugins.lang" },
    },
  })

  -- 颜色方案
  if type(M.colorscheme) == "function" then
    M.colorscheme()
  elseif M.colorscheme then
    vim.cmd.colorscheme(M.colorscheme)
  end

  -- LSP配置
  require("core.lsp")
end

return M
