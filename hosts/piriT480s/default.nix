{ dotfiles, ... }:
{
  home.username = "piri";
  home.homeDirectory = "/home/piri";
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.file.".config/tms/config.toml" = {
    source = "${dotfiles}/tms/config.toml";
  };
}
