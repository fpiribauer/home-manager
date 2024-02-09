{pkgs, ...}: {
  programs.neovim = 
  let 
    rf = builtins.readFile;
  in {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      neo-tree-nvim # File-browser
      vimwiki # Wiki
      luasnip
      {
        plugin = lualine-nvim;
        type = "lua";
        config = rf ./lualine.lua;
      } # Status Line
      {
        plugin = nvim-treesitter.withAllGrammars; # Syntax Highlighting
        type = "lua";
        config = rf ./treesitter.lua;
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup{}
        '';
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require("nvim-web-devicons").setup{}
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = rf ./telescope.lua;
      }
      plenary-nvim
      markdown-preview-nvim # Markdown Preview
      {
        plugin = gruvbox-material;
        type = "lua";
        config = ''
          vim.cmd[[colorscheme gruvbox-material]]
          vim.cmd[[highlight Normal ctermbg=NONE guibg=NONE]]
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup()
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = rf ./lspconfig.lua;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = rf ./nvim-cmp.lua;
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      vim-vsnip
      cmp-vsnip
    ];
    extraLuaConfig = rf ./config.lua;
    extraConfig = rf ./config.vimrc;
    extraPackages = with pkgs; [
      ripgrep # Requirement for telescope
    ];
  };
             }
