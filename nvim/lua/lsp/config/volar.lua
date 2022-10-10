local u = require("utils")
local opts = require("lsp.config.default")

local volar_opts = {
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
}

return {
  on_setup = function(server)
    server.setup(u.merge(opts, volar_opts))
  end,
}
