return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Find in files(Grep)" },
    },
    opts = {
      defaults = {
        -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
        initial_mode = "insert",
        -- 窗口内快捷键
        mappings = {
          i = {
            -- 上下移动
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-n>"] = "move_selection_next",
            ["<C-p>"] = "move_selection_previous",
            -- 历史记录
            ["<Down>"] = "cycle_history_next",
            ["<Up>"] = "cycle_history_prev",
            -- 关闭窗口
            -- ["<esc>"] = actions.close,
            ["<C-c>"] = "close",
            -- 预览窗口上下滚动
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-d>"] = "preview_scrolling_down",
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")

        -- <C-\><C-N> + q 关闭终端
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function()
        vim.cmd("startinsert!")
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit" })
      local terminal = Terminal:new()
      local function _lazygit_toggle()
        lazygit:toggle()
      end

      local function _terminal_toggle()
        terminal:toggle()
      end

      vim.keymap.set("n", "<leader>lg", _lazygit_toggle, { desc = "Open Lazygit" })
      vim.keymap.set("n", "<leader>lt", _terminal_toggle, { desc = "Open Terminal(root)" })
    end,
  },
}
