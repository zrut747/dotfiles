local u = require("utils")
local opts = require("lsp.config.default")

local emmet_opts = {
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "vue",
    "css",
    "sass",
    "scss",
    "less",
  }
}

return {
  on_setup = function(server)
    server.setup(u.merge(opts, emmet_opts))
  end,
}
