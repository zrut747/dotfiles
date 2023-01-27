local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local u = require("utils")
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

local opts = {
  git = {
    url_format = mirror .. '/%s.git',
  }
}

local plugins = {
  -- basic plugin
  "kyazdani42/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "rktjmp/lush.nvim",
  "SmiteshP/nvim-navic",
  -- theme
  "ellisonleao/gruvbox.nvim",
  "folke/tokyonight.nvim",
  "navarasu/onedark.nvim",
  -- nvim-tree
  "kyazdani42/nvim-tree.lua",
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "^3.0.0",
  },
  -- vim-bbye
  "moll/vim-bbye",
  -- lualine
  "nvim-lualine/lualine.nvim",
  "arkav/lualine-lsp-progress",
  -- telescope
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  -- alpha-nvim
  "goolord/alpha-nvim",
  -- treesistter
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "c853370",
    build = ":TSUpdate"
  },
  "p00f/nvim-ts-rainbow",
  "lewis6991/gitsigns.nvim",
  --------------------- LSP --------------------
  -- Lsp配置
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  -- 补全引擎
  "hrsh7th/nvim-cmp",
  -- Snippet 引擎
  "hrsh7th/vim-vsnip",
  -- 补全源
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
  "hrsh7th/cmp-buffer", -- { name = "buffer" },
  "hrsh7th/cmp-path", -- { name = "path" }
  "hrsh7th/cmp-cmdline", -- { name = "cmdline" }
  "hrsh7th/cmp-nvim-lsp-signature-help", -- { name = "nvim_lsp_signature_help" }
  -- 常见编程语言代码段
  "rafamadriz/friendly-snippets",
  -- UI 增强
  "onsails/lspkind-nvim",
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
  },
  "utilyre/barbecue.nvim",
  -- 代码格式化
  "jose-elias-alvarez/null-ls.nvim",
  -- Lua 增强
  "folke/lua-dev.nvim",
  -- TypeScript 增强
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  -- JSON 增强
  "b0o/schemastore.nvim",
  ----------------------------------------------
  -- Comment
  "numToStr/Comment.nvim",
  -- surround.vim
  "kylechui/nvim-surround",
  -- audopairs
  "windwp/nvim-autopairs",
  -- colorizer
  "norcalli/nvim-colorizer.lua",
  -- indent-blankline
  "lukas-reineke/indent-blankline.nvim",
  -- hop
  "phaazon/hop.nvim",
  -- leap
  "ggandor/leap.nvim",
  -- which-key
  "folke/which-key.nvim",
  -- outline
  "simrat39/symbols-outline.nvim",
  -- scratch
  "LintaoAmons/scratch.nvim",
  -- todo
  "folke/todo-comments.nvim",
  -- neoscroll
  "karb94/neoscroll.nvim",
}

require("lazy").setup(plugins, opts)
