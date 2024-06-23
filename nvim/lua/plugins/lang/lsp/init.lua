return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "folke/neodev.nvim",
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

      local lspconfig = require("lspconfig")
      local u = require("util")
      local default_config = require("plugins.lang.lsp.config.default")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local status, config = pcall(require, "plugins.mason.lsp.config." .. server_name)
          local handler_otps = {}
          if not status then
            handler_otps = {}
          else
            handler_otps = config.opts
          end
          -- 如果定义了setup方法，调用该配置自身的配置方法，否则和默认配置合并后调用默认的setup方法
          if config.setup ~= nil then
            config.setup(lspconfig[server_name])
          else
            lspconfig[server_name].setup(u.merge(default_config, handler_otps))
          end
        end,
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" } },
    },
    config = function()
      require("outline").setup()
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
