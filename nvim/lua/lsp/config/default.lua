local navic = require("nvim-navic")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local opt = {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    -- 绑定winbar
    navic.attach(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- 绑定快捷键
    require("keybindings").mapLSP(buf_set_keymap)
  end,
}

return opt
