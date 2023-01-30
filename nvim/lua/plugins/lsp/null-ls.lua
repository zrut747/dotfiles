local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local h = require("null-ls.helpers")
local u = require("null-ls.utils")

null_ls.setup({
  debug = false,
  sources = {
    -- frontend
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "markdown",
      },
      prefer_local = "node_modules/.bin",
    }),
    -- rust
    -- rustup component add rustfmt
    formatting.rustfmt,

    -- Python
    -- pip install black
    -- asdf reshim python
    formatting.black.with({ extra_args = { "--fast" } }),

    -- Diagnostics  ---------------------
    diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
      cwd = h.cache.by_bufnr(function(params)
        return u.root_pattern(
          ".eslintrc",
          ".eslintrcignore"
        )(params.bufname)
      end),
    }),
    -- code actions ---------------------
    code_actions.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(_)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
  end,
})
