require("mason").setup({
  github = {
    download_url_template = "https://kgithub.com/%s/releases/download/%s/%s",
    -- download_url_template = "https://hub.nuaa.cf.com/%s/releases/download/%s/%s",
  }
})
require("mason-lspconfig").setup({
  ensure_installed = {
    "volar", "sumneko_lua"
  },
  automatic_installation = false,
})

local lspconfig = require("lspconfig")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"),
  volar = require("lsp.config.volar"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end
