-- nvim-treesitter main branch: no more configs.setup, highlighting is started per buffer
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
