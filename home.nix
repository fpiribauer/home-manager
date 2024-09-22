{
  pkgs,
  unstablePkgs,
  config,
  dotfiles,
  nix-colors,
  ...
}@inputs:
let
  myutils = import ./myutils.nix inputs;
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./nvim/neovim.nix
#    ./wayland/sway.nix honestly its a mess, so we just use system way with its config...
    ./wayland/kanshi.nix
    ./wayland/waybar.nix
    ./wayland/notify.nix
    ./keybase/keybase.nix
    ./wasm/wasm.nix
    ./esp32/esp32.nix
  ];
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.username = "piri";
  home.homeDirectory = "/home/piri";
  home.file.".config/sway/config" = {
    #source = "${dotfiles}/sway/";
    #recursive = true;
    text = myutils.replaceTemplateColor (builtins.readFile "${dotfiles}/sway/config");
  };
  home.file.".config/sway/wallpaper.jpg" = {
    source = "${dotfiles}/sway/wallpaper.jpg";
  };
  home.file.".config/tms/config.toml" = {
    source = "${dotfiles}/tms/config.toml";
  };

  home.sessionPath = [
    "/opt/intelFPGA/20.1/modelsim_ase/bin"
  ];
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING=1; # Makes Java GUIs work nice with sway
  };

  #colorScheme = nix-colors.colorSchemes.base24.dracula;
  colorScheme = nix-colors.colorSchemes.base16.gruvbox-material-dark-medium;
  fonts.fontconfig.enable = true;
  home.packages = (with pkgs; [
    # Audio
    pipewire
    wireplumber
    # User Program
    anki
    # pyenv -- time is not yet ripe enough for such powerful inventions
    (
      nerdfonts.override
      {
        fonts = ["FiraCode" "JetBrainsMono" "Iosevka" "CascadiaCode" "CascadiaMono"];
      }
    )
    # LSP Stuff
    #nixd
    ruff-lsp
    pyright
    pavucontrol
    rust-analyzer
    tmux-sessionizer
    clang-tools_17
    vscode-extensions.ms-vscode.cpptools
    # Devops
    ansible
    ansible-lint
    # Games
    runelite
    thunderbird
  ]);

  systemd.user.targets = {
    sway-session = {
      Unit = {
        Description = "Sway compositor session";
        Documentation = [ "man:systemd.special" ];
        BindsTo = "graphical-session.target";
        Wants = "graphical-session-pre.target";
        After = "graphical-session-pre.target";
      };
    };
  };


  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = myutils.replaceTemplateColor (builtins.readFile "${dotfiles}/bash/bashrc");
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "CaskaydiaMonoNerdFontPropo:size=10";
      };
      # Use the color mapping from https://github.com/tinted-theming/tinted-foot/blob/main/templates/
      colors = let colors = myutils.colors; in {
        alpha = 0.95;
        foreground=colors.foreground;
        background=colors.background;
        regular0=colors.background;
        regular1=colors.red;
        regular2=colors.green;
        regular3=colors.yellow;
        regular4=colors.blue;
        regular5=colors.purple;
        regular6=colors.cyan;
        regular7=colors.foreground;
        bright0=colors.bright_black;
        bright1=colors.bright_red;
        bright2=colors.bright_green;
        bright3=colors.bright_yellow;
        bright4=colors.bright_blue;
        bright5=colors.bright_purple;
        bright6=colors.bright_cyan;
        bright7=colors.bright_white;
        "16"=colors.orange;
        "17"=colors.brown;
        "18"=colors.black;
        "19"=colors.bright_black;
        "20"=colors.light_gray;
        "21"=colors.white;
     };
    };
  };

}
