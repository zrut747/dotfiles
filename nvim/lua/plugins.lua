return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- gruvbox theme
    use {
        "ellisonleao/gruvbox.nvim",
        requires = {"rktjmp/lush.nvim"}
    }
    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    -- bufferline
    use {
      'akinsho/bufferline.nvim', 
      requires = 'kyazdani42/nvim-web-devicons'
    }
    -- treesistter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    use {
      'williamboman/mason.nvim',
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
  end,
  config = {
    -- 最大并发数
    max_jobs = 16,
    -- 自定义源
    git = {
      default_url_format = "https://kgithub.com/%s"
    },
  },
})
