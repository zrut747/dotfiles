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
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        -- 指定 snippet 引擎
        snippet = {
          expand = function(args)
            -- For `vsnip` users.
            vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` users.
            -- require('luasnip').lsp_expand(args.body)

            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)

            -- For `snippy` users.
            -- require'snippy'.expand_snippet(args.body)
          end,
        },
        -- 来源
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          -- For vsnip users.
          { name = "vsnip" },
          { name = "buffer" },
          -- For luasnip users.
          -- { name = 'luasnip' },
          --For ultisnips users.
          -- { name = 'ultisnips' },
          -- -- For snippy users.
          -- { name = 'snippy' },
        }, { { name = "path" } }),

        -- 快捷键
        mapping = require("config.keymaps").cmp(cmp),
        -- 使用lspkind-nvim显示类型图标
        formatting = require("plugins.lsp.ui").formatting,
      })

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
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
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
