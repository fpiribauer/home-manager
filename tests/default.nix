# Execute with nix eval .#tests
{ nix-colors, dotfiles, config,... }@inputs:
let
  mylib = import ../mylib inputs;
in
{
  inputs = inputs;
  color = mylib.utils.color;
  config = config;
  test=(nix-colors.lib.schemeFromYAML "hi"
''
system: "base24"
name: "Dracula"
author: "FredHappyface (https://github.com/fredHappyface)"
variant: "dark"
palette:
  base00: "282a36"
  base01: "363447"
  base02: "44475a"
  base03: "6272a4"
  base04: "9ea8c7"
  base05: "f8f8f2"
  base06: "f0f1f4"
  base07: "ffffff"
  base08: "ff5555"
  base09: "ffb86c"
  base0A: "f1fa8c"
  base0B: "50fa7b"
  base0C: "8be9fd"
  base0D: "80bfff"
  base0E: "ff79c6"
  base0F: "bd93f9"
  base10: "1e2029"
  base11: "16171d"
  base12: "f28c8c"
  base13: "eef5a3"
  base14: "a3f5b8"
  base15: "baedf7"
  base16: "a3ccf5"
  base17: "f5a3d2"
'');
  
  template = mylib.utils.renderTemplate {
    template="${dotfiles}/bash/bashrc"; context = { name = "test"; };
  };
}
