return {
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<leader>csr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        mappings = false
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>b", group = "Buffer" },
          { "<leader>q", group = "Quit" },
          { "<leader>l", group = "LSP" },
          { "<leader>d", group = "Debug" },
          { "<leader>f", group = "File" },
          { "<leader>x", group = "Trouble" },
          { "<leader>a", group = "AI" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
