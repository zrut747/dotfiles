local status, ib = pcall(require, "indent-blankline")
if not status then
  vim.notify("没有找到 bufferline")
  return
end

ib.setup({
  show_end_of_line = true,
  space_char_blankline = " ";
})
