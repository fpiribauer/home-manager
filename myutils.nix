{ config, lib, nix-colors, ...}:
let
  toBash = s : "\\[\\033[38;2;" + (nix-colors.lib.conversions.hexToRGBString ";" s) + "m\\]";
in
{
  replaceBase16 = s : let 
    prefix = "TEMPLATE_BASE16_";
    cp = config.colorScheme.palette; 
    hexdigits = ["00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0A" "0B" "0C" "0D" "0E" "0F"];
    colors = [cp.base00 cp.base01 cp.base02 cp.base03 cp.base04 cp.base05 cp.base06 cp.base07 cp.base08 cp.base09 cp.base0A cp.base0B cp.base0C cp.base0D cp.base0E cp.base0F];
  in (
    builtins.replaceStrings 
      (
        builtins.concatLists [
          (builtins.map (x: prefix + x) hexdigits)
          (builtins.map (x: prefix + "BASH_" +  x) hexdigits )
        ]
      )
      ( 
        builtins.concatLists [ colors (builtins.map (x: toBash x) colors) ]
      )
      s
  );
}
