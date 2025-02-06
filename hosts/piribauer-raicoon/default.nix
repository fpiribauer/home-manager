{ pkgs, ... }:
{
  cst.wayland.enable = true;

  home.username = "piribauer";
  home.homeDirectory = "/home/piribauer";
  home.packages = with pkgs; [
    bump2version
  ];

}
