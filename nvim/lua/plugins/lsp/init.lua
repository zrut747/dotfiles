return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- UI 增强
    "onsails/lspkind-nvim",
    {
      "glepnir/lspsaga.nvim",
      event = "BufRead",
    },
    -- 代码格式化
    "jose-elias-alvarez/null-ls.nvim",
    -- Lua 增强
    "folke/lua-dev.nvim",
    -- TypeScript 增强
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    -- json增强
    "b0o/schemastore.nvim",
  },
  config = function()
    require("plugins.lsp.setup")
    -- require("plugins.lsp.cmp")
    require("plugins.lsp.ui")
    require("plugins.lsp.null-ls")
  end
}
