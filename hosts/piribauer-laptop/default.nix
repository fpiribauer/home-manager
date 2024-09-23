
{ config, pkgs, ... } : {
  cst.wayland.enable = true;

  home.username = "fpiribauer";
  home.homeDirectory = "/home/fpiribauer";
}
