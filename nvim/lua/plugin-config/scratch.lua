local status, scratch = pcall(require, "scratch")
if not status then
  vim.notify("没有找到 lualine")
  return
end
scratch.setup {
  scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- Where the scratch files will be saved
  filetypes = { "json", "xml", "lua", "js", "py", "sh", "vue", "rs" }, -- filetypes to select from
}
