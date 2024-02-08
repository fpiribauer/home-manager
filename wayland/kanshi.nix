{ config, pkgs, ... }:
{
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
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
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
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };

      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };
    };
    
    #systemdTarget = "graphical-session.target";
  };
}
