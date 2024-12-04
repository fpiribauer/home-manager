{
  pkgs,
  dotfiles,
  nix-colors,
  nix-index-database,
  ...
}@inputs:
let
  mylib = import ./mylib inputs;
in
{
  imports = [
    nix-colors.homeManagerModules.default
    nix-index-database.hmModules.nix-index
    ./ssh
    ./nvim/neovim.nix
    #    ./wayland/sway.nix honestly its a mess, so we just use system way with its config...
    ./wayland
    ./wasm
    ./scd30
    ./esp32/esp32.nix
  ];
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.file.".config/tms/config.toml" = {
    source = "${dotfiles}/tms/config.toml";
  };

  home.sessionPath = [
    "/opt/intelFPGA/20.1/modelsim_ase/bin"
    "$HOME/.pyenv/bin"
  ];
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = 1; # Makes Java GUIs work nice with sway
  };

  #colorScheme = nix-colors.colorSchemes.base24.dracula;
  colorScheme = nix-colors.colorSchemes.base16.gruvbox-material-dark-medium;
  fonts.fontconfig.enable = true;
  home.packages = (
    with pkgs;
    [
      # Audio
      pipewire
      wireplumber
      pavucontrol
      # User Program
      anki
      element-desktop
      # pyenv -- time is not yet ripe enough for such powerful inventions
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.caskaydia-mono
      # Compilers
      zig
      clang-tools_17
      # LSP Stuff
      nixd
      nixfmt-rfc-style
      ruff-lsp
      pyright
      rustup
      ansible-language-server
      tmux-sessionizer
      vscode
      vscode-extensions.ms-vscode.cpptools
      vscode-extensions.jnoortheen.nix-ide
      # Devops
      ansible
      ansible-lint
      # Mail
      thunderbird
    ]
  );
  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    initExtra = builtins.readFile (
      mylib.utils.renderTemplate { template = "${dotfiles}/bash/bashrc"; }
    );
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      bind-key C-j display-popup -E "tms switch"
    '';
  };
}
