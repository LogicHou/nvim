-- 基础配置
require('basic')
-- Packer插件管理
require('plugins')
-- 快捷键映射
require('keybindings')
-- 主题设置
require('colorscheme')
-- 自动命令
require('autocmds')
-- 插件配置
require('plugin-config.nvim-tree')
require('plugin-config.bufferline')
require('plugin-config.lualine')
require('plugin-config.telescope')
require('plugin-config.dashboard')
require('plugin-config.project')
require('plugin-config.nvim-treesitter')
require('plugin-config.indent-blankline')
require('plugin-config.autopairs')
require('plugin-config.comment')
require('plugin-config.gitsigns')
require('plugin-config.hop')
require('plugin-config.trouble')
require('plugin-config.aerial')

-- 内置LSP
require('lsp.setup')
require('lsp.cmp')
require('lsp.ui')
-- require("lsp.formatter")
require('lsp.null-ls')

-- utils
-- require("utils.change-colorscheme")
-- 复制到windows剪贴板
require('utils.fix-yank')
require('utils.global')
