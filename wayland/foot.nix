{
  colors,
  lib,
  config,
  ...
}@inputs:
let
  mylib = import ../mylib inputs;
in
{
  options = {
    cst.foot.enable = lib.mkEnableOption "enables foot";
  };
  config = lib.mkIf config.cst.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "CaskaydiaMonoNerdFontPropo:size=10";
        };
        # Use the color mapping from https://github.com/tinted-theming/tinted-foot/blob/main/templates/
        colors =
          let
            color = mylib.utils.color.hex;
          in
          {
            alpha = 0.95;
            foreground = color.foreground;
            background = color.background;
            regular0 = color.background;
            regular1 = color.red;
            regular2 = color.green;
            regular3 = color.yellow;
            regular4 = color.blue;
            regular5 = color.purple;
            regular6 = color.cyan;
            regular7 = color.foreground;
            bright0 = color.bright_black;
            bright1 = color.bright_red;
            bright2 = color.bright_green;
            bright3 = color.bright_yellow;
            bright4 = color.bright_blue;
            bright5 = color.bright_purple;
            bright6 = color.bright_cyan;
            bright7 = color.bright_white;
            "16" = color.orange;
            "17" = color.brown;
            "18" = color.black;
            "19" = color.bright_black;
            "20" = color.light_gray;
            "21" = color.white;
          };
      };
    };
  };
}
