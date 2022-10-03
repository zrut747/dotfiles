require("mason").setup({
  github = {
    download_url_template = "https://kgithub.com/%s/releases/download/%s/%s",
    -- download_url_template = "https://hub.nuaa.cf.com/%s/releases/download/%s/%s",
  }
})
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "sumneko_lua",
    "rust_analyzer",
    "taplo",
    -- frontend
    "html",
    "cssls",
    "emmet_ls",
    "jsonls",
    "tsserver",
    "volar",
  },
  automatic_installation = false,
})

local lspconfig = require("lspconfig")
local default_config = require("lsp.config.default")
local u = require("utils")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"),
  bashls = require("lsp.config.bash"),
  html = require("lsp.config.html"),
  cssls = require("lsp.config.css"),
  emmet_ls = require("lsp.config.emmet"),
  jsonls = require("lsp.config.json"),
  tsserver = require("lsp.config.ts"),
  volar = require("lsp.config.volar"),
  rust_analyzer = require("lsp.config.rust"),
  taplo = "",
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(u.merge(default_config, lspconfig[name]))
  else
    -- 使用默认参数
    lspconfig[name].setup(default_config)
  end
  vim.notify(default_config)
end
