return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "󰈞  > Find file", ":cd $HOME/workspace | Telescope find_files<CR>"),
        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:h | :Neotree <CR>"),
        dashboard.button("l", "󰒲  > Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
      }
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<A-m>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    opts = {
      window = {
        mappings = {
          ["o"] = "open",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Remove Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Remove Buffer (Force)",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Move To Prev Buffer" },
      { "<C-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Move To Next Buffer" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Remove Left Buffers" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Remove Right Buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Remove Other Buffers" },
    },
    opts = {
      options = {
        -- 关闭 Tab 的命令
        close_command = function(bufnum)
          require("mini.bufremove").delete(bufnum, false)
        end,
        -- 侧边栏配置
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
          reveal = { "close" },
        },
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPre",
    opts = function()
      return {
        symbol = "│",
        options = { try_as_border = true },
      }
    end,
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
    opts = function()
      local icons = require("core").icons
      return {
        options = {
          section_separators = { left = "", right = "" },
          component_separators = { left = "|", right = "|" },
          globalstatus = true,
        },
        extensions = { "neo-tree" },
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
          },
          lualine_x = {
            {
              "fileformat",
              symbols = {
                unix = "", -- LF
                dos = "", -- CRLF
                mac = "", -- CR
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
    end,
  },
  {
    "echasnovski/mini.animate",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end
      local animate = require("mini.animate")
      return {
        cursor = {
          enable = false,
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
}
