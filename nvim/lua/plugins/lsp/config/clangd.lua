local capabilities = require("cmp_nvim_lsp").default_capabilities()
local opt = {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    require("plugins.lsp.keymaps").map(bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opt)
  end,
}
