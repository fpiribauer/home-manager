{ ... }:
{
  home.username = "piri";
  home.homeDirectory = "/home/piri";
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.file.".config/tms/config.toml".text = ''
    [[search_dirs]]
    path = "/home/piri"
    depth = 2
  '';
}
