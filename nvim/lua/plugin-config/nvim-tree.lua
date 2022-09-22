require'nvim-tree'.setup {
  view = {
    mappings = {
      list = require("keybindings").nvimTreeList
    }
  },
  -- 不显示 git 状态图标
  git = {
      enable = false
  }
}
