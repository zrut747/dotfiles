local tools_registry = {
  lsp = {
    "clangd",
    "lua-language-server",
    "pyright",
    "prettypst",
  },
  dap = {
    "debugpy",
  },
  formatters = {
    "stylua",
    "prettierd",
    "gofumpt",
  },
}

return {
  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
      local mason_registry = require("mason-registry")

      local function ensure_installed()
        for category, tools in pairs(tools_registry) do
          for _, tool in ipairs(tools) do
            if not mason_registry.is_installed(tool) then
              local ok, pkg = pcall(mason_registry.get_package, tool)
              if ok then
                pkg:install()
              else
                vim.notify(string.format("Package %s (%s) not found in registry", tool, category), vim.log.levels.WARN)
              end
            end
          end
        end
      end

      mason_registry.refresh(vim.schedule_wrap(ensure_installed))
    end,
  },
}
