return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  init = function ()
    require("plugins.llm.fidget-spinner"):init()
  end,
  config = function()
    require("codecompanion").setup({
      adapters = {
        opts = {
          -- show_defaults 会导致copilot不能正常工作
          show_defaults = true,
          -- log_level = "DEBUG",
        },
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
                default = "deepseek-chat",
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
}
