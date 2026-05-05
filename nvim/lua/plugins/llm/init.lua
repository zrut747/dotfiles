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
            return require("codecompanion.adapters").extend("deepseek", {
              name = "deepseek",
              env = {
                api_key = function()
                  return os.getenv("DEEPSEEK_API_KEY")
                end,
              },
              schema = {
                model = {
                  default = "deepseek-v4-flash",
                  choices = {
                    ["deepseek-v4-flash"] = { opts = { can_reason = true } },
                    ["deepseek-v4-pro"] = { opts = { can_reason = true } }
                  },
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
    ft = { "markdown", "codecompanion" }, -- 关键：指定在 codecompanion 窗口中启用
  }
}
