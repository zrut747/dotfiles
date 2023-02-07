return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "p00f/nvim-ts-rainbow",
  },
  build = ":TSUpdate",
  opts = {
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = {
      "html",
      "css",
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
    },
    -- 启用代码高亮功能
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    -- 彩虹括号
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    -- 启用增量选择
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>',
        node_decremental = '<BS>',
        scope_incremental = '<TAB>',
      }
    },
    -- 启用基于Treesitter的代码格式化
    indent = {
      enable = true
    },
    -- 注释配置
    context_commentstring = {
      enable = true,
      config = {
        typescript = { __default = '// %s', __multiline = '/* %s */' }
      }
    },
  },
  config = function(_, opts)
    local u = require("util")
    local github_mirror = u.github_mirror()
    -- local github_mirror = "https://hub.nuaa.cf"
    for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
      config.install_info.url = config.install_info.url:gsub("https://github.com", github_mirror)
    end
    require("nvim-treesitter.configs").setup(opts)
    -- 开启 Folding
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    -- 默认不要折叠
    -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
    vim.wo.foldlevel = 99
  end
}
