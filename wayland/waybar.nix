{ config, pkgs, pkgs-23-11, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./waybar.css;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        output = [
          "*"
        ];

        modules-left = ["sway/workspaces" "sway/mode" "cpu" "memory" "custom/co2"];
        modules-center = [];
        modules-right = ["pulseaudio" "backlight" "network" "battery" "clock"];


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

        "custom/co2" = {
          exec = ./display.py;
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
            default = ["" ""];
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
          "format-icons" =  ["" "" "" "" ""];
        };

        clock = {
          "format-alt" = "{:%a, %d. %b  %H:%M}";
        };



      };
    };
  };
}
