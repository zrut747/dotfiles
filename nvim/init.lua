-- 基础设置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 设置主题
require("colorscheme")
-- 自动命令
require("autocmds")
-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.alpha-nvim")
require("plugin-config.nvim-treesitter")
require("plugin-config.gitsigns")
require("plugin-config.comment")
require("plugin-config.nvim-surround")
require("plugin-config.autopairs")
require("plugin-config.indent-blankline")
require("plugin-config.leap")
require("plugin-config.which-key")
require("plugin-config.nvim-colorizer")
require("plugin-config.scratch")
require("plugin-config.todo-comments")
require("plugin-config.neoscroll")
require("plugin-config.barbecue")
-- lsp配置
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
require("lsp.null-ls")
