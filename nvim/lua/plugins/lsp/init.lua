return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Lua 增强
      "folke/lua-dev.nvim",
      -- TypeScript 增强
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      -- json增强
      "b0o/schemastore.nvim",
    },
    opts = {
      diagnostics = {
        virtual_text = true,
        signs = true,
        update_in_insert = false,
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)
      local signs = require("config").icons.diagnostics
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      require("plugins.lsp.lsp-setup")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.lsp.null-ls-setup")
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    opts = function()
      local github_mirror = require("util").github_mirror()
      return {
        mason_opts = {
          github = {
            download_url_template = string.format("%s/%%s/releases/download/%%s/%%s", github_mirror),
          },
        },
        lsp_opts = {
          ensure_installed = {
            "bashls",
            "clangd",
            "lua_ls",
            "rust_analyzer",
            "pyright",
            "taplo",
            -- frontend
            "html",
            "cssls",
            "emmet_ls",
            "jsonls",
            "tsserver",
            "volar",
          },
        },
        null_ls_opts = {
          ensure_installed = { "stylua" },
        },
      }
    end,
    config = function(_, opts)
      require("mason").setup(opts.mason_opts)
      require("mason-lspconfig").setup(opts.lsp_opts)
      require("mason-null-ls").setup(opts.null_ls_opts)
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    opts = {
      experimental = {
        pathStrict = true,
      },
    },
  },
}
