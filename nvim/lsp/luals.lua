return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      -- completion = {
      --   enable = true,
      -- },
      diagnostics = {
        enable = true,
      },
      -- telemetry = {
      --   enable = false,
      -- },
    },
  },
}
