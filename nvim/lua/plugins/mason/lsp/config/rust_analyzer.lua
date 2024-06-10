local M = {}
local opts = require("plugins.lsp.config.default")
local u = require("util")

local rust_opts = {
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
M.setup = function(server)
  opts = u.merge(opts, rust_opts)
  local status, rust_tools = pcall(require, "rust_tools")
  if not status then
    server.setup(opts)
  else
    rust_tools.setup({
      server = opts,
    })
  end
end

return M
