{ pkgs, config, nix-colors, ... }:
let
  cp = config.colorScheme.palette; 
  colors16 = rec {
    background = cp.base00;
    black = cp.base01;
    bright_black = cp.base02;
    gray = cp.base03;
    light_gray = cp.base04;
    foreground = cp.base05;
    white = cp.base06;
    bright_white = cp.base07;
    bright_red = cp.base08;
    orange = cp.base09;
    bright_yellow = cp.base0A;
    bright_green = cp.base0B;
    bright_cyan = cp.base0C;
    bright_blue = cp.base0D;
    bright_purple = cp.base0E;
    brown = cp.base0F;
    # Extend to 24 bit
    darker_black = background;
    darkest_black = background;
    red = bright_red;
    yellow = bright_yellow;
    green = bright_green;
    cyan = bright_cyan;
    blue = bright_blue;
    purple = bright_purple;
  };
  colors24 = colors16 // {
    darker_black = cp.base10;
    darkest_black = cp.base11;
    red = cp.base12;
    yellow = cp.base13;
    green = cp.base14;
    cyan = cp.base15;
    blue = cp.base16;
    purple = cp.base17;
  };
  toBash = s : "\\[\\033[38;2;" + (nix-colors.lib.conversions.hexToRGBString ";" s) + "m\\]";
  colors' =
    (if config.colorScheme.system == "base16" then
      colors16
    else if config.colorScheme.system == "base24" then
      colors24
    else abort "Unknown colorScheme system ${config.colorScheme.system}");
  color = { hex = colors'; bash = builtins.mapAttrs (k: v: toBash v) colors'; };

in
{
  color = color;
  
  renderTemplate = { template, context ? { inherit color; } }:
  let
    context_json = pkgs.writeText "context-json" (builtins.toJSON context);
  in
  pkgs.runCommand "rendered-template" {} ''${pkgs.mustache-go}/bin/mustache ${context_json} ${template} > $out'';

}
