-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

local capabilities = require('blink.cmp').get_lsp_capabilities()
return {
  capabilities = capabilities,
}
