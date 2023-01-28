return {
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          mappings = {
            list = require("config.keymaps").nvimTreeList
          }
        },
        -- 不显示 git 状态图标
        git = {
          enable = false
        }
      }
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
          initial_mode = "insert",
          -- 窗口内快捷键
          mappings = require("config.keymaps").telescopeList,
        },
        pickers = {
          -- 内置 pickers 配置
          find_files = {
            -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
            -- theme = "dropdown",
          }
        },
        extensions = {
          -- 扩展插件配置
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          }
        },
      })
      require("telescope").load_extension("ui-select")
    end
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        }
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "css",
        "javascript",
        "typescript",
        "vue",
        "less",
        "scss",
      })
    end
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap")
    end
  },
  {
    "LintaoAmons/scratch.nvim",
    config = function()
      require("scratch").setup {
        scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- Where the scratch files will be saved
        filetypes = { "json", "xml", "lua", "js", "py", "sh", "vue", "rs" }, -- filetypes to select from
      }
    end
  }
}
