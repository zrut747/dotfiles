return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<space>f",
      function()
        require("conform").format({ lsp_fallback = true, async = true })
      end,
      desc = "Format Document",
    },
  },
  opts = function()
    return {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
      },
    }
  end,
}
