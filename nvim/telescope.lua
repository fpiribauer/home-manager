local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>af', function() builtin.find_files({ hidden = true, follow = true }) end, {})
vim.keymap.set('n', '<leader>ag', function() builtin.live_grep({ additional_args = { "--hidden" } }) end, {})
require("telescope").setup{}
