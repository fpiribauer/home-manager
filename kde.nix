{ config, pkgs, ... }:

{
  imports = [
    <plasma-manager/modules>
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      tooltipDelay = 5;
      theme = "otto";
      colorScheme = "Otto";
      wallpaper = "${pkgs.libsForQt5.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images/1080x1920.png";
    };
  };

}
