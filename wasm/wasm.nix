{pkgs, ...}: {
  home.packages = with pkgs; [
    wasm-pack
    wabt
    cargo-generate
    nodejs_22
  ];
}
