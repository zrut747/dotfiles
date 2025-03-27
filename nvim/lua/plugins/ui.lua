return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>ff", "<cmd>lua Snacks.picker.files()<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>lua Snacks.picker.grep()<CR>", desc = "Find in files(Grep)" },
    },
    opts = {
      scroll = { enabled = true },
      input = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "s", desc = "Settings", action = ":e $MYVIMRC | :cd %:h | :Neotree <CR>" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
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
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove",
    },
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>bprev<CR>", desc = "Move To Prev Buffer" },
      { "<C-l>", "<cmd>bnext<CR>", desc = "Move To Next Buffer" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Remove Left Buffers" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Remove Right Buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Remove Other Buffers" },
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
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
