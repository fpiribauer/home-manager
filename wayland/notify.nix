
{config, lib, pkgs, ...}: {
  options = {
    cst.notify.enable = lib.mkEnableOption "enables wayland notify";
  };
  config = {
    services.mako = lib.mkIf config.cst.notify.enable {
      enable = true;
      anchor = "top-center";
      defaultTimeout = 5000;
    };
  };
}
