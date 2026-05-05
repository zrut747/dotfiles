return {
  {
    "arborist-ts/arborist.nvim",
    event = "VeryLazy",
    opts = {
      update_cadence = "weekly",
      prefer_wasm = false,
      auto_install = true,
      install_popular = false,
      ensure_installed = {
        "c",
        "cpp",
        "html",
        "css",
        "scss",
        "vim",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "rust",
        "java",
        "python",
        "markdown",
        "markdown_inline",
        "vimdoc",
        "yaml",
      }
    },
    config = function(_, opts)
      require("arborist").setup(opts)
    end,
  }
}
