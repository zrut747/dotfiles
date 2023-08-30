return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = function()
      local github_mirror = require("util").github_mirror()
      local lsp_list = require("plugins.mason.lsp-list")
      -- local install_servers = {}
      -- for _, ele in pairs(lsp_list) do
      --   table.insert(install_servers, ele.name)
      -- end

      return {
        mason_opts = {
          github = {
            download_url_template = string.format("%s/%%s/releases/download/%%s/%%s", github_mirror),
          },
        },
        lsp_opts = {
          ensure_installed = lsp_list,
        },
      }
    end,
    config = function(_, opts)
      require("mason").setup(opts.mason_opts)
      require("mason-lspconfig").setup(opts.lsp_opts)

      -- 安装formatter
      local formatter_list = require("plugins.mason.formatter-list")
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
