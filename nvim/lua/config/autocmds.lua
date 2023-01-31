local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 保存时自动格式化
autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = { "*.lua", "*.py", "*.sh", ".vue" },
  callback = vim.lsp.buf.formatting_sync,
})

-- 用o换行不要延续注释
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
  end,
})

-- wsl 使用宿主机剪切板
if string.find(vim.fn.system("uname -r"), "microsoft") then
  vim.cmd [[
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
    augroup END
  ]]
end
