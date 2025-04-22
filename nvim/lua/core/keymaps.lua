local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------
-- 使用 jk 退出 insert 模式
map("i", "jk", "<ESC>")

-- 保存退出
map("n", "<leader>qq", "<cmd>wqa<CR>")

-- treesitter 折叠
map("n", "zc", "<cmd>foldclose<CR>")
map("n", "zo", "<cmd>foldopen<CR>")

-- 注释
map({ "n", "v" }, "<C-_>", "gcc", { remap = true })

--------------------------------------------------------------------
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
require("util").on_attach(function(_, buf)
  -- rename
  map("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename", buffer = buf })
  map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action", buffer = buf })
  map("n", "<leader>ls", "<cmd>lua Snacks.picker.lsp_symbols()<CR>", { desc = "LSP Symbols", buffer = buf })
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition", buffer = buf })
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto Declaration", buffer = buf })
  map("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Goto Next Declaration", buffer = buf })
  map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Goto Prev Declaration", buffer = buf })
  map("n", "gr", "<cmd>lua Snacks.picker.lsp_references()<CR>", { desc = "References", buffer = buf })
  map("n", "gI", "<cmd>lua Snacks.picker.lsp_implementations()<CR>", { desc = "Goto Implementation", buffer = buf })
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover", buffer = buf })
end)
-- DAP
map("n", "<F5>", "<cmd>DapContinue<CR>")
map("n", "<F10>", "<cmd>DapStepOver<CR>")
map("n", "<F11>", "<cmd>DapStepInto<CR>")
map("n", "<F12>", "<cmd>DapStepOut<CR>")
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
map("n", "<leader>dB", function()
  -- 弹出输入框，提示用户输入条件
  vim.ui.input({ prompt = "Enter condition: " }, function(condition)
    if not condition or condition == "" then
      print("Condition is empty, no breakpoint set.")
      return
    end

    -- 设置条件断点
    require("dap").set_breakpoint(condition)
  end)
end, { desc = "Set conditional breakpoint" })
-- AI
map("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", {desc = "AI Chat"})
map({"n", "v"}, "<leader>aa", "<cmd>CodeCompanionActions<CR>", {desc = "AI Actions"})
-- Codeium
map("i", "<A-p>", "<cmd> lua require('codeium.virtual_text').debounced_complete()<CR>", { desc = "Codeium" })
