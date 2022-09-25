local status, ns = pcall(require, "nvim-surround")
if not status then
  vim.notify("没有找到 nvim-surround")
  return
end

ns.setup({})
