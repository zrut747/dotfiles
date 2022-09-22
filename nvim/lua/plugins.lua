require("packer").startup({
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    -- gruvbox theme
    use {
        "ellisonleao/gruvbox.nvim",
        requires = {"rktjmp/lush.nvim"}
    }
    -- nvim-tree
    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons"
    }
    -- bufferline
    use {
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons"
    }
    -- lualine
    use{
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
    use{
      "goolord/alpha-nvim",
      requires = "kyazdani42/nvim-web-devicons"
    }
    -- treesistter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    --------------------- LSP --------------------
    -- Lsp配置
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
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
    -- 代码格式化
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim"
    })
    -- Lua 增强
    use("folke/lua-dev.nvim")
    ----------------------------------------------
    ---- Comment
    use("numToStr/Comment.nvim")
  end,
  config = {
    -- 最大并发数
    max_jobs = 16,
    -- 自定义源
    git = {
      default_url_format = "https://kgithub.com/%s"
      -- default_url_format = "https://hub.nuaa.cf/%s"
    },
  },
})
