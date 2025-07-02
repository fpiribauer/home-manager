{ pkgs, ... }:
{
  cst.wayland.enable = true;

  home.username = "piribauer";
  home.homeDirectory = "/home/piribauer";
  home.packages = with pkgs; [
    bump2version
    s3cmd
    kubectl
    k9s
    jq
  ];

  home.file.".config/tms/config.toml" = {
    text = ''
    [[search_dirs]]
    path = "/home/piribauer/raicoon"
    depth = 3
    [[search_dirs]]
    path = "/home/piribauer/my_demos"
    depth = 1
    [[search_dirs]]
    path = "/home/piribauer/git"
    depth = 1
    [[search_dirs]]
    path = "/home/piribauer/.config/home-manager"
    depth = 1
    '';
  };

}
