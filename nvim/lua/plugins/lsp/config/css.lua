local u = require("util")
local opts = require("plugins.lsp.config.default")

local css_opts = {
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
}

return {
  on_setup = function(server)
    server.setup(u.merge(opts, css_opts))
  end,
}
