local M = {}
M.opts = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}

return M
