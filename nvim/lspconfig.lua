local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig_util = require("lspconfig.util")
local servers = {
  {
    "nixd",
    {
      capabilities = capabilities,
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
          formatting = {
            command = { "nixfmt" },
          },
          options = {
            home_manager = {
              expr = '(builtins.getFlake ("git+file://" + toString /home/piri/.config/home-manager)).homeConfigurations."piri@T480piri".options',
            },
            home_manager2 = {
              expr = '(builtins.getFlake ("git+file://" + toString /home/fpiribauer/.config/home-manager)).homeConfigurations."fpiribauer@piribauer-laptop".options',
            },
          },
        },
      },
    },
  },
  { "pyright", { capabilities = capabilities } },
  { "ruff",   { capabilities = capabilities } },
  { "svls",   { capabilities = capabilities } },
  { "clangd", { capabilities = capabilities } },
  {
    "rust_analyzer",
    {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            buildScripts = { enable = true },
            extraEnv = {
              ["CARGO_PROFILE_RUST_ANALYZER_INHERITS"] = "dev",
            },
            extraArgs = { "--profile", "rust-analyzer" },
            features = "all",
          },
          check = {
            overrideCommand = { "cargo", "clippy", "--message-format=json", "--all-targets", "--all-features" },
          },
          rustfmt = {
            extraArgs = { "+nightly" },
          },
          procMacro = {
            attributes = {
              enable = true,
            },
          },
        },
      },
    },
  },
  {
    "ansiblels",
    {
      filetypes = { "yaml", "yml", "ansible" },
      root_dir = lspconfig_util.root_pattern("roles", "playbooks"),
    }
  },
}

for _, srv in ipairs(servers) do
  local name = srv[1]
  local config = srv[2]

  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- Setup lspsaga
require("lspsaga").setup({
  lightbulb = {
    sign = false
  }
})
vim.keymap.set({'n'}, '<leader>t', '<Cmd>Lspsaga term_toggle<CR>')


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev(); vim.cmd.normal('zz') end)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next(); vim.cmd.normal('zz') end)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Setup lspsaga
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gf', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup;
        buffer = ev.buf,
        callback = function ()
            -- Disable Autoformatting on save for now...
            -- vim.lsp.buf.format({ bufnr = bufnr})
        end,
    })

  end,
})
