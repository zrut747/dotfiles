return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
      }
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)
      local signs = require("config").icons.diagnostics
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      require("plugins.lsp.setup")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      local h = require("null-ls.helpers")
      local u = require("null-ls.utils")
      return {
        debug = false,
        sources = {
          -- frontend
          formatting.prettier.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "markdown",
            },
            prefer_local = "node_modules/.bin",
          }),
          -- rust
          -- rustup component add rustfmt
          formatting.rustfmt,

          -- Python
          -- pip install black
          -- asdf reshim python
          formatting.black.with({ extra_args = { "--fast" } }),

          -- Diagnostics  ---------------------
          diagnostics.eslint.with({
            prefer_local = "node_modules/.bin",
            cwd = h.cache.by_bufnr(function(params)
              return u.root_pattern(
                ".eslintrc",
                ".eslintrcignore"
              )(params.bufname)
            end),
          }),
          -- code actions ---------------------
          code_actions.eslint.with({
            prefer_local = "node_modules/.bin",
          }),
        },
        -- #{m}: message
        -- #{s}: source name (defaults to null-ls if not specified)
        -- #{c}: code (if available)
        diagnostics_format = "[#{s}] #{m}",
        on_attach = function(_)
          vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
        end,
      }
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup()
    end
  },
  {
    "folke/neodev.nvim",
    opts = {
      experimental = {
        pathStrict = true
      }
    }
  },
}
