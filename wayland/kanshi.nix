{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    cst.kanshi.enable = lib.mkEnableOption "enables kanshi";
  };

  config = lib.mkIf config.cst.kanshi.enable {
    home.packages = (
      with pkgs;
      [
        kanshi
      ]
    );
    services.kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "uniofficen";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-6";
              status = "enable";
            }
          ];
        }
        {
          profile.name = "unioffice";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-7";
              status = "enable";
            }
          ];
        }
        {
          profile.name = "unioffice2";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-5";
              status = "enable";
              position = "0,0";
            }
            {
              criteria = "DP-6";
              status = "enable";
              position = "1920,0";
            }
          ];
          profile.exec = [
            "swaymsg workspace 1, move workspace to DP-6"
            "swaymsg workspace 2, move workspace to DP-6"
            "swaymsg workspace 3, move workspace to DP-6"
            "swaymsg workspace 4, move workspace to DP-5"
            "swaymsg workspace 5, move workspace to DP-5"
            "swaymsg workspace 6, move workspace to DP-5"
            "swaymsg workspace 7, move workspace to DP-6"
            "swaymsg workspace 8, move workspace to DP-6"
            "swaymsg workspace 9, move workspace to DP-6"
            "swaymsg workspace 10, move workspace to DP-5"
            "sleep 1 && swaymsg workspace 1"
          ];
        }
        {
          profile.name = "docked";
          profile.outputs = [
            {
              criteria = "DP-3";
              status = "enable";
              position = "1080,370";
            }
            {
              criteria = "DP-4";
              status = "enable";
              position = "3000,370";
            }
            {
              criteria = "DP-5";
              status = "enable";
              position = "0,0";
              transform = "90";
              mode = "1920x1080@60Hz";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
          profile.exec = [
            "swaymsg workspace 1, move workspace to DP-3"
            "swaymsg workspace 2, move workspace to DP-4"
            "swaymsg workspace 3, move workspace to DP-5"
            "swaymsg workspace 4, move workspace to DP-3"
            "swaymsg workspace 5, move workspace to DP-3"
            "swaymsg workspace 6, move workspace to DP-3"
            "swaymsg workspace 7, move workspace to DP-3"
            "swaymsg workspace 8, move workspace to DP-3"
            "swaymsg workspace 9, move workspace to DP-3"
            "swaymsg workspace 10, move workspace to DP-3"
            "sleep 1 && swaymsg workspace 1"
          ];

        }

        {
          profile.name = "weird";
          profile.outputs = [
            {
              criteria = "DP-6";
              status = "enable";
              position = "1080,370";
            }
            {
              criteria = "DP-7";
              status = "enable";
              position = "3000,370";
            }
            {
              criteria = "DP-8";
              status = "enable";
              position = "0,0";
              transform = "90";
              mode = "1920x1080@60Hz";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
          profile.exec = [
            "swaymsg workspace 1, move workspace to DP-6"
            "swaymsg workspace 2, move workspace to DP-7"
            "swaymsg workspace 3, move workspace to DP-8"
            "swaymsg workspace 4, move workspace to DP-6"
            "swaymsg workspace 5, move workspace to DP-6"
            "swaymsg workspace 6, move workspace to DP-6"
            "swaymsg workspace 7, move workspace to DP-6"
            "swaymsg workspace 8, move workspace to DP-6"
            "swaymsg workspace 9, move workspace to DP-6"
            "swaymsg workspace 10, move workspace to DP-6"
            "sleep 1 && swaymsg workspace 1"
          ];
        }

        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
          profile.exec = [
            "swaymsg workspace 1, move workspace to eDP-1"
            "swaymsg workspace 2, move workspace to eDP-1"
            "swaymsg workspace 3, move workspace to eDP-1"
            "swaymsg workspace 4, move workspace to eDP-1"
            "swaymsg workspace 5, move workspace to eDP-1"
            "swaymsg workspace 6, move workspace to eDP-1"
            "swaymsg workspace 7, move workspace to eDP-1"
            "swaymsg workspace 8, move workspace to eDP-1"
            "swaymsg workspace 9, move workspace to eDP-1"
            "swaymsg workspace 10, move workspace to eDP-1"
            "sleep 1 && swaymsg workspace 1"
          ];
        }
      ];

      #systemdTarget = "graphical-session.target";
    };
  };
}
