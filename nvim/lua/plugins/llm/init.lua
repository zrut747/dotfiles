return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "j-hui/fidget.nvim",
    },
    init = function()
      require("plugins.llm.fidget-spinner"):init()
    end,
    config = function()
      require("codecompanion").setup({
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("openai", {
              url = "https://api.deepseek.com/chat/completions",
              name = "deepseek",
              env = {
                api_key = "DEEPSEEK_API_KEY",
              },
              schema = {
                model = {
                  default = "deepseek-v4-flash",
                  choices = { "deepseek-v4-flash", "deepseek-v4-pro" },
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "deepseek" },
          inline = { adapter = "deepseek" },
        },
        opts = {
          language = "Chinese",
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        -- 1. 配置 AI 提供商为 OpenAI 兼容格式
        provider = "openai_fim_compatible", -- 使用支持 FIM (Fill-in-the-Middle) 的 OpenAI 兼容接口
        -- 提供商的具体配置 (API 密钥、端点等)
        provider_options = {
          openai_fim_compatible = {
            end_point = "https://api.deepseek.com/beta/completions",
            api_key = "DEEPSEEK_API_KEY",
            name = "deepseek",
            model = "deepseek-v4-flash",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
        -- 2. 配置虚拟文本显示
        virtualtext = {
          -- 可选: 设置哪些文件类型会自动触发补全，留空则完全手动控制
          auto_trigger_ft = {},
          keymap = {
            next = "<A-p>", -- 手动触发/显示下一个建议
            accept = "<Tab>", -- 接受全部补全内容
            dismiss = "<A-e>", -- 取消补全
          },
        },
      })
    end,
  },
}
