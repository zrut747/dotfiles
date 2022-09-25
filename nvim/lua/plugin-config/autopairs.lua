local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
  vim.notify("没有找到 hop")
  return
end

autopairs.setup()
