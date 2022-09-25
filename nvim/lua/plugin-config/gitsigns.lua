local status, gitsigns = pcall(require, "gitsigns")
if not status then
  vim.notify("没有找到 gitsigns")
  return
end

gitsigns.setup()
