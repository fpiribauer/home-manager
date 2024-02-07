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
        config = rf nvim/lualine.lua;
      } # Status Line
      {
        plugin = nvim-treesitter.withAllGrammars; # Syntax Highlighting
        type = "lua";
        config = rf nvim/treesitter.lua;
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
        config = rf nvim/telescope.lua;
      }
      plenary-nvim
      markdown-preview-nvim # Markdown Preview
      {
        plugin = gruvbox-material;
        type = "lua";
        config = ''
          vim.cmd[[colorscheme gruvbox-material]]
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup()
        '';
      }
    ];
    extraLuaConfig = rf nvim/config.lua;
    extraConfig = rf nvim/config.vimrc;
    extraPackages = with pkgs; [
      ripgrep # Requirement for telescope
    ];
  };
             }
