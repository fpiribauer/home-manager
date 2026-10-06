{
  config,
  lib,
  ...
}:
{
  options = {
    cst.ssh.enable = lib.mkEnableOption "enables ssh client config";
  };
  config = lib.mkIf config.cst.ssh.enable {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      # Private hosts live in ~/.ssh/config.local, which is not part of this repo
      includes = [ "config.local" ];
      settings."*" = {
        AddKeysToAgent = "yes";
      };
    };
  };
}
