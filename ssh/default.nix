{ lib, ... }:
{
  imports = [
    ./ssh.nix
  ];
  config = {
    cst.ssh.enable = lib.mkDefault true;
  };
}
