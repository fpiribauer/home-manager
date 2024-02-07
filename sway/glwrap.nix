{ pkgs, ...}:

pkg:

let
  nixGL = pkgs.nixgl;
  bins = "${pkg}/bin";
in
pkgs.buildEnv {
  name = "nixGL-${pkg.name}";
  paths =
    [ pkg ] ++
    (map
      (bin: pkgs.hiPrio (
          # For some reason auto detection generates impure code... 
          # So hardcoe IntelGPU for now...
          # exec -a "$0" "${nixGL.auto.nixGLDefault}/bin/nixGL" "${bins}/${bin}" "$@"
        pkgs.writeShellScriptBin bin ''
          exec -a "$0" "${nixGL.nixGLIntel}/bin/nixGLIntel" "${bins}/${bin}" "$@"
        ''
      ))
      (builtins.attrNames (builtins.readDir bins)));
}
