{ config, pkgs, ... }@input:
let
 gw = import ./glwrap.nix input;
in
{


  wayland.windowManager.sway = {
    enable = true;
    package = gw pkgs.sway;

    config = rec {
      modifier = "Mod1";
      terminal = "konsole";

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";  
        }
      ];
    };

  };


  programs.waybar =
    let
      swayEnabled = config.wayland.windowManager.sway.enable;
    in
    {
      enable = swayEnabled;
      settings = [{
        layer = "top";
        position = "top";
        modules-left = if swayEnabled then [ "sway/workspaces" ] else [ ];
        modules-center = if swayEnabled then [ "sway/window" ] else [ ];
        modules-right =
          [ "pulseaudio" "cpu" "memory" "temperature" "clock" "tray" ];
        clock.format = "{:%Y-%m-%d %H:%M}";
        "tray" = { spacing = 8; };
        "cpu" = { format = "cpu {usage}"; };
        "memory" = { format = "mem {}"; };
        "temperature" = {
          hwmon-path = "/sys/class/hwmon/hwmon1/temp2_input";
          format = "tmp {temperatureC}C";
        };
        "pulseaudio" = {
          format = "vol {volume} {format_source}";
          format-bluetooth = "volb {volume} {format_source}";
          format-bluetooth-muted = "volb {format_source}";
          format-muted = "vol {format_source}";
          format-source = "mic {volume}";
          format-source-muted = "mic";
        };
      }];
    };

}
