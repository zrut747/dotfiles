-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local M = {}
M.opts = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      workspace = {
        library = {
          "/usr/share/nvim/runtime/lua",
          "/usr/share/nvim/runtime/lua/lsp",
          "/usr/share/awesome/lib",
        },
      },
      completion = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        globals = {
    --     -- vim全局配置
          "vim",
          -- awesome全局配置
          "awesome",
          "client",
          "root",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return M
