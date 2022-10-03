local u = require("utils")
local opts = require("lsp.config.default")

local json_opts = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}

return {
  on_setup = function(server)
    server.setup(u.merge(opts, json_opts))
  end,
}
