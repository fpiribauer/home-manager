{ pkgs, dotfiles, ... }:
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
  home.file.".config/tms/config.toml" = {
    source = "${dotfiles}/tms/config.toml";
  };
}
