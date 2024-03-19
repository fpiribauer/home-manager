{
  pkgs,
  unstablePkgs,
  config,
  dotfiles,
  nix-colors,
  ...
}@input:
let
  myutils = import ./myutils.nix input;
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./nvim/neovim.nix
#    ./wayland/sway.nix honestly its a mess, so we just use system way with its config...
    ./wayland/kanshi.nix
    ./wayland/waybar.nix
    ./keybase/keybase.nix
  ];
  
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.username = "piri";
  home.homeDirectory = "/home/piri";
  home.file.".config/sway/config" = {
    #source = "${dotfiles}/sway/";
    #recursive = true;
    text = myutils.replaceBase16 (builtins.readFile "${dotfiles}/sway/config");
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

  colorScheme = nix-colors.colorSchemes.gruvbox-material-dark-medium;
  fonts.fontconfig.enable = true;
  home.packages = (with pkgs; [
    anki
    # pyenv -- time is not yet ripe enough for such powerful inventions
    (
      nerdfonts.override
      {
        fonts = ["FiraCode" "JetBrainsMono" "Iosevka" "CascadiaCode" "CascadiaMono"];
      }
    )
    #nixd
    ruff-lsp
    pyright
    pavucontrol
    rust-analyzer
    tmux-sessionizer
    clang-tools_17
    vscode-extensions.ms-vscode.cpptools
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
    initExtra = builtins.readFile "${dotfiles}/bash/bashrc";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "CaskaydiaMonoNerdFontPropo:size=10";
      };
      colors = let cp = config.colorscheme.palette; in {
        alpha = 0.95;
        foreground=cp.base05;
        background=cp.base00;
        regular0=cp.base00; # black
        regular1=cp.base08; # red
        regular2=cp.base0B; # green
        regular3=cp.base0A; # yellow
        regular4=cp.base0D; # blue
        regular5=cp.base0E; # magenta
        regular6=cp.base0C; # cyan
        regular7=cp.base05; # white
        bright0=cp.base03; # bright black
        bright1=cp.base08; # bright red
        bright2=cp.base0B; # bright green
        bright3=cp.base0A; # bright yellow
        bright4=cp.base0D; # bright blue
        bright5=cp.base0E; # bright magenta
        bright6=cp.base0C; # bright cyan
        bright7=cp.base07; # bright white
        "16"=cp.base09;
        "17"=cp.base0F;
        "18"=cp.base01;
        "19"=cp.base02;
        "20"=cp.base04;
        "21"=cp.base06;
      };
    };
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
