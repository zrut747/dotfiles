return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = function()
      local lsp_list = require("plugins.lang.lsp.lsp-list")
      return {
        ensure_installed = lsp_list,
      }
    end,
    config = function(_, opts)
      -- 安装LSP
      require("mason-lspconfig").setup(opts)
      -- 安装formatter
      local formatter_list = require("plugins.lang.formatter.formatter-list")
      local mason_registry = require("mason-registry")

      local ensure_installed = function()
        for _, name in pairs(formatter_list) do
          if not mason_registry.is_installed(name) then
            local package = mason_registry.get_package(name)
            package:install()
          end
        end
      end
      mason_registry.refresh(vim.schedule_wrap(ensure_installed))
    end,
  },
}
