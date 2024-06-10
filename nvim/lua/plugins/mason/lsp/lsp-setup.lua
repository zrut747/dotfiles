local lspconfig = require("lspconfig")
local u = require("util")

local default_config = require("plugins.mason.lsp.config.default")
local lsp_list = require("plugins.mason.lsp.lsp-list")

for _, ele in pairs(lsp_list) do
  local opts = {}
  local status, config = pcall(require, "plugins.mason.lsp.config." .. ele)
  if not status then
    opts = {}
  else
    opts = config.opts
  end
  -- 如果定义了setup方法，调用该配置自身的配置方法，否则和默认配置合并后调用默认的setup方法
  if config.setup ~= nil then
    config.setup(lspconfig[ele])
  else
    lspconfig[ele].setup(u.merge(default_config, opts))
  end
end
