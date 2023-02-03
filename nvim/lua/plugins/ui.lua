return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  > Find file", ":cd $HOME/workspace | Telescope find_files<CR>"),
        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:h | :Neotree <CR>"),
        dashboard.button("l", "鈴 > Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
      }
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
    end
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = ">",
      },
    },
    version = "*",
    config = function(_, opts)
      require("barbecue").setup(opts)
    end
  },
  {
    "akinsho/bufferline.nvim",
    version = "^3.0.0",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove",
    },
    opts = {
      options = {
        -- 关闭 Tab 的命令
        close_command = function(bufnum)
          require('mini.bufremove').delete(bufnum, false)
        end,
        right_mouse_command = function(bufnum)
          require('mini.bufremove').delete(bufnum, false)
        end,
        -- 侧边栏配置
        -- 左侧让出 neo-tree 的位置，显示文字 File Explorer
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        -- 鼠标悬浮显示关闭按钮
        hover = {
          enabled = true,
          delay = 100,
          reveal = { 'close' }
        },
        -- 使用 nvim 内置 LSP
        diagnostics = "nvim_lsp",
        -- 可选，显示 LSP 报错图标
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icons = require("config").icons
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and icons.diagnostics.Error or
                (e == "warning" and icons.diagnostics.Warn or icons.diagnostics.Info)
            s = s .. n .. sym
          end
          return s
        end,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end
  },
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPre",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "arkav/lualine-lsp-progress",
    },
    opts = function()
      local icons = require("config").icons
      return {
        options = {
          section_separators = { left = '', right = '' },
          component_separators = { left = '|', right = '|' },
          globalstatus = true,
        },
        extensions = { "nvim-tree" },
        sections = {
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_c = {
            "filename",
            {
              "lsp_progress",
              spinner_symbols = { '|', '/', '-', '\\' },
            },
          },
          lualine_x = {
            {
              "fileformat",
              symbols = {
                unix = '', -- LF
                dos = '', -- CRLF
                mac = '', -- CR
              },
            },
            "encoding",
            "filetype",
          },
        },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end
  },
  {
    "echasnovski/mini.surround",
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  }
}
