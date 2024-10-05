{ pkgs, ... }:
{

  cst.wayland.enable = true;
  cst.wasm.enable = true;
  cst.scd30.enable = true;

  home.username = "piri";
  home.homeDirectory = "/home/piri";
  home.packages = (
    with pkgs;
    [
      # Games
      runelite
    ]
  );
}
