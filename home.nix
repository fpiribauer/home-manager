{
  pkgs,
  dotfiles,
  nix-colors,
  ...
}@inputs:
let
  mylib = import ./mylib inputs;
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./ssh
    ./nvim/neovim.nix
    ./foot.nix
  ];

  # Not on NixOS (Arch): sets XDG_DATA_DIRS etc. so desktop entries and fonts are found
  targets.genericLinux.enable = true;

  #colorScheme = nix-colors.colorSchemes.base24.dracula;
  colorScheme = nix-colors.colorSchemes.base16.gruvbox-material-dark-medium;
  fonts.fontconfig.enable = true;
  cst.foot.enable = true;
  # GUI apps like chromium and code (OSS) come from pacman, nix GUI apps need nixGL on Arch
  home.packages = (
    with pkgs;
    [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.caskaydia-mono

      tmux-sessionizer
      ## LSP Stuff (for editing this repo)
      nixd
      nixfmt
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
