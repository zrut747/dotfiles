return {
  {
    "IlyasYOY/ts-pack.nvim",
    config = function()
      local ts_pack = require('ts-pack')
      local library = require('ts-pack.library')

      ts_pack.add(library.select({
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
      }), { async = true })
    end,
  },
}
