local capabilities = require("cmp_nvim_lsp").default_capabilities()
local opt = {
  capabilities = capabilities,
   flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.documentFormattingProvider = false

    -- 绑定快捷键
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require("plugins.lsp.keymaps").mapLSP(buf_set_keymap)
  end,
}

return opt
