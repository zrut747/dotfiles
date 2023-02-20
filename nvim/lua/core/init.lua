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
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Null = "ﳠ ",
      Number = " ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    },
  },
}

M = u.merge(M, default)

M.setup = function()
  require("core.options")
  require("core.keymaps")
  require("core.autocmds")

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
      url_format = mirror .. "/%s.git",
    },
  })

  if type(M.colorscheme) == "function" then
    M.colorscheme()
  else
    vim.cmd.colorscheme(M.colorscheme)
  end
end

return M
