return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- mason
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      diagnostics = {
        virtual_text = true,
        signs = true,
        update_in_insert = false,
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)
      local signs = require("core").icons.diagnostics
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      require("plugins.mason.lsp.lsp-setup")
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lspsaga").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      experimental = {
        pathStrict = true,
      },
    },
  },
}
