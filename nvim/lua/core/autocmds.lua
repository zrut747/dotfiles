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

-- wsl 使用宿主机剪切板
if vim.fn.has("wsl") == 1 then
  autocmd("TextYankPost", {
    group = myAutoGroup,
    pattern = "*",
    callback = function()
      vim.fn.system("/mnt/c/windows/system32/clip.exe", vim.fn.getreg('"'))
    end,
  })
end
