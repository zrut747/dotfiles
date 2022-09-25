local status, wk = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which-key")
  return
end

wk.setup()
