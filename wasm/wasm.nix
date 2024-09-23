{ config, lib, pkgs, ...}: {
  options = {
    cst.wasm.enable = lib.mkEnableOption "enables wasm";
  };
  config = lib.mkIf config.cst.wasm.enable {
    home.packages = with pkgs; [
      wasm-pack
      wabt
      cargo-generate
      nodejs_22
    ];
  };
}
