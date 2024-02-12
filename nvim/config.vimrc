:set number
:set expandtab
set mouse=
set clipboard+=unnamedplus
set cursorlineopt=number
if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
au FileType css setlocal tabstop=2 shiftwidth=2
au FileType haskell setlocal tabstop=2 shiftwidth=2
au FileType nix setlocal tabstop=2 shiftwidth=2
au FileType json setlocal tabstop=2 shiftwidth=2
au FileType cpp setlocal tabstop=2 shiftwidth=2
au FileType c setlocal tabstop=2 shiftwidth=2
au FileType java setlocal tabstop=2 shiftwidth=2
au FileType markdown setlocal spell
au FileType markdown setlocal tabstop=2 shiftwidth=2
au FileType systemverilog setlocal tabstop=2 shiftwidth=2
au FileType verilog setlocal tabstop=2 shiftwidth=2
au CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
au BufRead,BufNewFile *.wiki setlocal textwidth=80 spell tabstop=2 shiftwidth=2
au FileType xml setlocal tabstop=2 shiftwidth=2
au FileType help wincmd L
au FileType gitcommit setlocal spell
