local u = require("util")
local opts = require("plugins.lsp.config.default")

local volar_opts = {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
}

return {
  on_setup = function(server)
    server.setup(u.merge(opts, volar_opts))
  end,
}
