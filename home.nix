{
  pkgs,
  unstablePkgs,
  dotfiles,
  ...
}: {
  imports = [
    ./nvim/neovim.nix
#    ./sway/sway.nix honestly its a mess, so we just use system way with its config...
  ];
  
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.username = "piri";
  home.homeDirectory = "/home/piri";
  home.file.".config/sway/" = {
    source = "${dotfiles}/sway/";
    recursive = true;
  };


  fonts.fontconfig.enable = true;
  home.packages = (with pkgs; [
    anki
    pyenv
    (
      nerdfonts.override
      {
        fonts = ["FiraCode" "JetBrainsMono" "Iosevka" "CascadiaCode" "CascadiaMono"];
      }
    )
    nixd
    ruff-lsp
    pyright
  ]);


  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = builtins.readFile "${dotfiles}/bash/bashrc";
  };



  nixpkgs.overlays = [
    (final: prev: {
      powerline-go = unstablePkgs.powerline-go.overrideAttrs (o: {
        patches = (o.patches or []) ++ [./powerline.patch];
      });
    })
  ];
  programs.powerline-go = {
    enable = true;
    modules = [
      "venv"
      "cwd"
      "perms"
      "git"
      "exit"
    ];
  };

}
