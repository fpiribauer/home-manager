{ config, lib, ... }: {
  imports = [
    ./waybar.nix
    ./kanshi.nix
    ./notify.nix
    ./foot.nix
  ];
  options = {
    cst.wayland.enable = lib.mkEnableOption "enables wayland";
  };
  config = lib.mkIf config.cst.wayland.enable {
    cst.waybar.enable = lib.mkDefault true;
    cst.kanshi.enable = lib.mkDefault true;
    cst.notify.enable = lib.mkDefault true;
    cst.foot.enable = lib.mkDefault true;
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


  };
}
