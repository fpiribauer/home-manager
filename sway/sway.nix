{ config, pkgs, ... }@input:
let
 gw = import ./glwrap.nix input;
in
{


  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "konsole";
    };
    package = gw pkgs.sway;

  };

}
