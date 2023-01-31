return {
  {
    -- 补全引擎
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet 引擎
      "hrsh7th/vim-vsnip",
      -- 补全源
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
      "hrsh7th/cmp-buffer", -- { name = "buffer" },
      "hrsh7th/cmp-path", -- { name = "path" }
      "hrsh7th/cmp-cmdline", -- { name = "cmdline" }
      "hrsh7th/cmp-nvim-lsp-signature-help", -- { name = "nvim_lsp_signature_help" }
      -- 常见编程语言代码段
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      local cmp = require("cmp")
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      return {
        -- 指定 snippet 引擎
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        -- 来源
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          -- For vsnip users.
          { name = "vsnip" },
          { name = "buffer" },
        }, { { name = "path" } }),

        -- 快捷键
        mapping = {
          ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        },
        -- cmp提示显示lspkind类型图标
        formatting = {
          format = function(_, item)
            local icons = require("config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
      }
    end,

    config = function(_, opts)
      vim.g.vsnip_snippet_dir = "~/.config/nvim/snippet"

      local cmp = require('cmp')
      cmp.setup(opts)
      -- Use buffer source for `/`.
      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" },
        },
      })
      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Normal and Visual modes
        comment = 'gc',
        -- Toggle comment on current line
        comment_line = 'gcc',
        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        textobject = 'gc',
      },
      -- Hook functions to be executed at certain stage of commenting
      hooks = {
        -- Before successful commenting. Does nothing by default.
        pre = function() end,
        -- After successful commenting. Does nothing by default.
        post = function() end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end
  },
}
