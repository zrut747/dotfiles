local M = {}

local u = require("util")

local function get_default_config()
  return {
    colorscheme = function()
      vim.cmd("colorscheme catppuccin")
    end,
  }
end

--- 使用 vim.pack 安装 lazy.nvim（Neovim 0.12 内置的包管理接口）
local function setup_lazy()
  vim.pack.add({
    {
      src = "https://github.com/folke/lazy.nvim.git",
      name = "lazy.nvim",
      version = "stable",
    },
  })

  local ok, lazy = pcall(require, "lazy")
  if not ok then
    vim.notify("lazy.nvim 加载失败", vim.log.levels.ERROR)
    return false
  end
  return true
end

M = u.merge(M, get_default_config())

M.setup = function()
  -- 基础配置
  require("core.options")
  require("core.keymaps")
  require("core.autocmds")

  -- 插件管理（通过 vim.pack 安装/加载 lazy.nvim）
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

  -- LSP 配置
  require("core.lsp")
end

return M

