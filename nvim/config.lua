vim.wo.relativenumber = true
vim.api.nvim_set_option_value("colorcolumn", "79", {})
vim.api.nvim_set_option_value("signcolumn", "yes:1", {})

vim.g.mapleader = " "

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
