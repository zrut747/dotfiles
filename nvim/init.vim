" 基础设置
lua require('basic')

" 快捷键映射
lua require('keybindings')

" Packer插件管理
lua require('plugins')

" 设置主题
set background=dark
colorscheme gruvbox

" 插件配置
lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/lualine')
lua require('plugin-config/alpha-nvim')
lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/mason')

" lsp配置
lua require('lsp/setup')
lua require('lsp/cmp')
lua require('lsp/ui')
