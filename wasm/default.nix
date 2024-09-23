{ lib, ... }: {
  imports = [
    ./wasm.nix
  ];
  config = {
    cst.wasm.enable = lib.mkDefault true; 
  };
}
