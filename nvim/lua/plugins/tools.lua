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
          { "<leader>b", group = "buffer" },
          { "<leader>q", group = "quit" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file" },
          { "<leader>x", group = "trouble" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
