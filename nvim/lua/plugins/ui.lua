return {
  {
    "goolord/alpha-nvim",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  > Find file", ":cd $HOME/workspace | Telescope find_files<CR>"),
        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
      }

      -- Send config to alpha
      require("alpha").setup(dashboard.opts)
    end
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        symbols = {
          ---modification indicator
          ---@type string
          modified = "●",

          ---truncation indicator
          ---@type string
          ellipsis = "…",

          ---entry separator
          ---@type string
          separator = ">",
        },
      })
    end
  },
  {
    "akinsho/bufferline.nvim",
    version = "^3.0.0",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove",
    },
    config = function()
      -- bfferline 配置
      -- https://github.com/akinsho/bufferline.nvim#configuration
      require("bufferline").setup({
        options = {
          -- 关闭 Tab 的命令
          close_command = function(bufnum)
            require('mini.bufremove').delete(bufnum, false)
          end,
          right_mouse_command = function(bufnum)
            require('mini.bufremove').delete(bufnum, false)
          end,
          -- 侧边栏配置
          -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
          offsets = {
            {
              filetype = "NvimTree",
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
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or " ")
              s = s .. n .. sym
            end
            return s
          end,
        },
      })
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
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_end_of_line = true,
        space_char_blankline = " ";
      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "arkav/lualine-lsp-progress",
    },
    config = function()
      require("lualine").setup({
        options = {
          section_separators = { left = '', right = '' },
          component_separators = { left = '|', right = '|' },
          globalstatus = true,
        },
        extensions = { "nvim-tree" },
        sections = {
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
      })
    end
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  }
}
