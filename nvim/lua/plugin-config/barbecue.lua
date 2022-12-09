local status, barbecue = pcall(require, "barbecue")
if not status then
  vim.notify("没有找到 barbecue")
  return
end

barbecue.setup({
  symbols = {
    ---modification indicator
    ---@type string
    modified = "●",

    ---truncation indicator
    ---@type string
    ellipsis = "…",

    ---entry separator
    ---@type string
    separator = ">",
  },
})
