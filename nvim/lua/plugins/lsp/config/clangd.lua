local capabilities = require("cmp_nvim_lsp").default_capabilities()
local opt = {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    require("plugins.lsp.keymaps").map(bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opt)
  end,
}
