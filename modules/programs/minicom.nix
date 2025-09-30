{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.minicom;
in {
  meta.maintainers = [lib.hm.maintainers.mforster]; # only temporary

  options.programs.minicom = {
    enable = lib.mkEnableOption "Modem control and terminal emulation program";

    package = lib.mkPackageOption pkgs "minicom" {};

    settings = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Contents of /etc/minirc.dfl";
      example = ''
        pu port             /dev/ttyUSB0
        pu baudrate         115200
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    home.file."minirc.dfl".text = cfg.settings;
  };
}
