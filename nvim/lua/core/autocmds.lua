local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 用o换行不要延续注释
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    -- O and o, don't continue comments
    vim.opt.formatoptions:remove("o")
    -- But do continue when pressing enter.
    vim.opt.formatoptions:append("r")
  end,
})
