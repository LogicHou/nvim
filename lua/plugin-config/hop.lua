-- 如果找不到 hop 组件，就不继续执行
local status, hop = pcall(require, 'hop')
if not status then
    vim.notify('没有找到 hop')
    return
end

hop.setup({
    keys = 'etovxqpdygfblzhckisuran',
    vim.api.nvim_set_keymap(
        'n',
        'f',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        {}
    ),
    vim.api.nvim_set_keymap(
        'n',
        'F',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        {}
    ),
    vim.api.nvim_set_keymap('n', 'ww', '<cmd>:HopWord<cr>', {}),
})
