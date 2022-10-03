return {
  on_setup = function(server)
    server.setup({
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "css",
        "sass",
        "scss",
        "less",
      }
    })
  end,
}
