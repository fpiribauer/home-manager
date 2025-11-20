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
    nix-index-database.homeModules.nix-index
    ./ssh
    ./nvim/neovim.nix
    #    ./wayland/sway.nix honestly its a mess, so we just use system way with its config...
    ./wayland
    ./wasm
    ./scd30
    ./esp32/esp32.nix
  ];
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionPath = [
    "/opt/intelFPGA/20.1/modelsim_ase/bin"
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
      brave
      p7zip
      anki
      element-desktop
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.caskaydia-mono
      # Mail
      thunderbird

      # Developer stuff
      uv
      claude-code
      ## Compilers
      zig
      elan
      ## LSP Stuff
      nixd
      nixfmt-rfc-style
      ruff
      pyright
      rustup
      tmux-sessionizer
      vscode
      vscode-extensions.ms-vscode.cpptools
      vscode-extensions.jnoortheen.nix-ide
      ## Devops
      ansible
      ansible-lint
      jinja2-cli
      kubectl
      k9s
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
      bind-key C-n display-popup -E "tms"

      set -g mouse on
      # to enable mouse scroll, see https://github.com/tmux/tmux/issues/145#issuecomment-150736967
      bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"

      # Allow xterm titles in terminal window, terminal scrolling with scrollbar, and setting overrides of C-Up, C-Down, C-Left, C-Right
      # This seems wrong, it does weird stuff
      # set -g terminal-overrides "xterm*:XT:smcup@:rmcup@:kUP5=\eOA:kDN5=\eOB:kLFT5=\eOD:kRIT5=\eOC"

      # Scroll History
      set -g history-limit 30000

      # Set ability to capture on start and restore on exit window data when running an application
      setw -g alternate-screen on

      # Lower escape timing from 500ms to 50ms for quicker response to scroll-buffer access.
      set -s escape-time 50
    '';
  };
}
