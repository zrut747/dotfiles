local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------
-- 使用 jk 退出 insert 模式
map("i", "jk", "<ESC>")

-- 保存退出
map("n", "<leader>qq", ":wqa<CR>")

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>")
map("n", "zo", ":foldopen<CR>")

-- 注释
map({ "n", "v" }, "<C-_>", "gcc", { remap = true })

--------------------------------------------------------------------
-- DAP
map("n", "<F5>", ":DapContinue<CR>")
map("n", "<F10>", ":DapStepOver<CR>")
map("n", "<F11>", ":DapStepInto<CR>")
map("n", "<F12>", ":DapStepOut<CR>")
map("n", "<leader>db", ":DapToggleBreakpoint<CR>")
-- map("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.ui.input('Enter condition: '))<CR>")
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
