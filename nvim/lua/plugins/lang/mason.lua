local tools = {
  lsp = {
    "clangd",
    "lua-language-server",
    "pyright",
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
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
      local mason_registry = require("mason-registry")

      local function ensure_installed()
        for category, tool_list in pairs(tools) do
          for _, tool in ipairs(tool_list) do
            if not mason_registry.is_installed(tool) then
              local ok, pkg = pcall(mason_registry.get_package, tool)
              if ok then
                pkg:install()
              end
            end
          end
        end
      end

      mason_registry.refresh(vim.schedule_wrap(ensure_installed))
    end,
  },
}
