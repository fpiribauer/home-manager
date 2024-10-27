{
  config,
  lib,
  ...
}@inputs:
let
  mylib = import ../mylib inputs;
  waybarcss = mylib.utils.renderTemplate { template = ./waybar.css; };
in
{
  options = {
    cst.waybar.enable = lib.mkEnableOption "enables waybar";
  };
  config = lib.mkIf config.cst.waybar.enable {
    home.shellAliases = {
      rwaybar = "systemctl --user restart waybar";
    };
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = waybarcss;
      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          output = [
            "*"
          ];

          modules-left = [
            "sway/workspaces"
            "sway/mode"
            "cpu"
            "memory"
            (lib.mkIf config.cst.scd30.enable "custom/co2")
          ];
          modules-center = [ ];
          modules-right = [
            "pulseaudio"
            "backlight"
            "network"
            "battery"
            "custom/clock"
          ];

          cpu = {
            interval = 15;
            format = "  {}%";
            max-length = 10;
          };

          memory = {
            interval = 30;
            format = "  {}%";
            max-length = 10;
          };

          "custom/co2" = lib.mkIf config.cst.scd30.enable {
            exec = config.cst.scd30.displayScript;
            interval = 30;
            format = "co2 {}ppm";
          };

          "pulseaudio" = {
            format = "{volume}% {icon}";
            format-bluetooth = "{volume}% {icon}";
            format-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
              ];
            };
            scroll-step = 1;
            on-click = "pavucontrol";
          };

          backlight = {
            tooltip = false;
            format = " {}%";
            interval = 1;
            on-scroll-up = "brightnessctl s 1515";
            on-scroll-down = "brightnessctl s 1";
          };

          network = {
            format = "{ifname}";
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} 󰊗";
            format-disconnected = "󰤮";
            tooltip-format = "{ifname} via {gwaddr} 󰊗";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} ";
            tooltip-format-disconnected = "Disconnected";
            max-length = 50;
          };

          battery = {
            format = "{capacity}% {icon}";
            "format-icons" = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          clock = {
            "format-alt" = "{:%a, %d. %b  %H:%M}";
          };

          "custom/clock" = {
            "format" = "   {}  ";
            "interval" = 60;
            "exec" = "date +'%d %a %H:%M'";
          };

        };
      };
    };
  };
}
