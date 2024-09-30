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
  };
}
