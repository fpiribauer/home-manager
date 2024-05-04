{pkgs, ...}: {
  home.packages = with pkgs; [
    wasm-pack
    cargo-generate
    nodejs_22
  ];
}
