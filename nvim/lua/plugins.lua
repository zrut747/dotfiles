local u = require("utils")
local mirror = u.github_mirror()
-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    string.format("%s/wbthomason/packer.nvim", mirror),
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    -- gruvbox theme
    use {
      "ellisonleao/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" }
    }
    use("folke/tokyonight.nvim")
    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons"
    }
    -- bufferline
    use {
      "akinsho/bufferline.nvim",
      tag = "v2.*",
      requires = "kyazdani42/nvim-web-devicons"
    }
    -- vim-bbye
    use("moll/vim-bbye")
    -- lualine
    use {
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons"
    }
    use("arkav/lualine-lsp-progress")
    -- telescope
    use {
      "nvim-telescope/telescope.nvim",
      require = "nvim-lua/plenary.nvim"
    }
    -- alpha-nvim
    use {
      "goolord/alpha-nvim",
      requires = "kyazdani42/nvim-web-devicons"
    }
    -- treesistter
    use {
      "nvim-treesitter/nvim-treesitter",
      commit = "c853370",
      run = ":TSUpdate"
    }
    use("p00f/nvim-ts-rainbow")
    use "lewis6991/gitsigns.nvim"
    --------------------- LSP --------------------
    -- Lsp配置
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- Snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = "buffer" },
    use("hrsh7th/cmp-path") -- { name = "path" }
    use("hrsh7th/cmp-cmdline") -- { name = "cmdline" }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = "nvim_lsp_signature_help" }
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- UI 增强
    use("onsails/lspkind-nvim")
    use("glepnir/lspsaga.nvim")
    use("SmiteshP/nvim-navic")
    -- 代码格式化
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim"
    })
    -- Lua 增强
    use("folke/lua-dev.nvim")
    -- TypeScript 增强
    use({
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      requires = "nvim-lua/plenary.nvim"
    })
    -- JSON 增强
    use("b0o/schemastore.nvim")
    ----------------------------------------------
    -- Comment
    use("numToStr/Comment.nvim")
    -- surround.vim
    use("kylechui/nvim-surround")
    -- audopairs
    use("windwp/nvim-autopairs")
    -- colorizer
    use("norcalli/nvim-colorizer.lua")
    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")
    -- hop
    use("phaazon/hop.nvim")
    -- which-key
    use("folke/which-key.nvim")
    -- outline
    use("simrat39/symbols-outline.nvim")
  end,
  config = {
    -- 最大并发数
    max_jobs = 16,
    -- 自定义源
    git = {
      default_url_format = string.format("%s/%%s", mirror)
      -- default_url_format = "https://hub.nuaa.cf/%s"
    },
  },
})
