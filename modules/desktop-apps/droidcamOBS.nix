{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  options = {
    droidcamOBS.enable = lib.mkEnableOption "enables droidcam OBS";
  };

  config = lib.mkIf config.droidcamOBS.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    environment.systemPackages = with pkgs; [
      droidcam
      v4l-utils
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          droidcam-obs
        ];
      })
    ];

    programs.droidcam.enable = true;
  };
}
