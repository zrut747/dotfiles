return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  opts = function()
    return {
      -- 安装 language parser
      -- :TSInstallInfo 命令查看支持的语言
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
        "typst",
      },
      -- 启用代码高亮功能
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- 启用增量选择
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      -- 启用基于Treesitter的代码格式化
      indent = {
        enable = true,
      },
    }
  end,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
