{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    cst.scd30.enable = lib.mkEnableOption "enables scd30 alerting";
    cst.scd30.displayScript = lib.mkOption {
      default = (
        (pkgs.writers.writePython3Bin "scd30-display" {
          libraries = [ pkgs.python3Packages.dbus-python ];
          flakeIgnore = [ "E501" ];
        } ./display.py)
        + "/bin/scd30-display"
      );
      description = "Path to script that prints the current CO2 value in ppm";
      example = "/usr/bin/samplescript";
      type = lib.types.path;
    };
  };
  config = lib.mkIf config.cst.scd30.enable {
    systemd.user.services = {
      scd30-alerter = {
        Service = {
          Type = "oneshot";
          ExecStart = config.cst.scd30.displayScript + " notify";
        };
        Unit = {
          Description = "Polls SCD30 sensor and alerts on high CO2 concentration";
          Wants = "graphical-session-pre.target";
          After = "graphical-session-pre.target";
        };
      };
    };
    systemd.user.timers = {
      scd30-alerter = {
        Unit = {
          Description = "10 second alerter timer";
        };
        Timer = {
          OnCalendar = "*:0/1";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
