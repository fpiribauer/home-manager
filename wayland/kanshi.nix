{ config, pkgs, ... }:
{
  home.packages = (with pkgs; [
    kanshi
  ]);
  services.kanshi = {
    enable = true;
    profiles = {
      docked = {
        outputs = [
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
        exec = [
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

      };

      weird = {
        outputs = [
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
        exec = [
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
      };

      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
        exec = [
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
      };
    };
    
    #systemdTarget = "graphical-session.target";
  };
}
