{ colors, lib, config,  ... }@inputs: 
let
  mylib = import ../mylib inputs;
in {
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
        colors = let colors = mylib.utils.colors; in {
          alpha = 0.95;
          foreground=colors.foreground;
          background=colors.background;
          regular0=colors.background;
          regular1=colors.red;
          regular2=colors.green;
          regular3=colors.yellow;
          regular4=colors.blue;
          regular5=colors.purple;
          regular6=colors.cyan;
          regular7=colors.foreground;
          bright0=colors.bright_black;
          bright1=colors.bright_red;
          bright2=colors.bright_green;
          bright3=colors.bright_yellow;
          bright4=colors.bright_blue;
          bright5=colors.bright_purple;
          bright6=colors.bright_cyan;
          bright7=colors.bright_white;
          "16"=colors.orange;
          "17"=colors.brown;
          "18"=colors.black;
          "19"=colors.bright_black;
          "20"=colors.light_gray;
          "21"=colors.white;
        };
      };
    };
  };
}
