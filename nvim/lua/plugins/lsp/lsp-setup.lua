local lspconfig = require("lspconfig")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  clangd = require("plugins.lsp.config.clangd"),
  lua_ls = require("plugins.lsp.config.lua"),
  bashls = "",
  html = "",
  cssls = require("plugins.lsp.config.css"),
  emmet_ls = require("plugins.lsp.config.emmet"),
  jsonls = require("plugins.lsp.config.json"),
  -- tsserver = require("plugins.lsp.config.ts"),
  volar = require("plugins.lsp.config.volar"),
  rust_analyzer = require("plugins.lsp.config.rust"),
  -- taplo = "",
  pyright = "",
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup(require("plugins.lsp.config.default"))
  end
end
