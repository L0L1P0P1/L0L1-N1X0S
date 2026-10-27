{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  tauon = (
    pkgsUnstable.tauon.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
        pkgsUnstable.gobject-introspection
        pkgsUnstable.wrapGAppsNoGuiHook
      ];
      buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
        pkgsUnstable.pango
        pkgsUnstable.gdk-pixbuf
        pkgsUnstable.librsvg
        pkgsUnstable.libnotify
        pkgsUnstable.gtk3
      ];
      dontWrapGApps = true;
      preFixup = (oldAttrs.preFixup or "") + ''
        makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
      '';
    })
  );
in
{
  options = {
    tauon.enable = lib.mkEnableOption "enables Tauon";
  };

  config = lib.mkIf config.tauon.enable {
    environment.systemPackages = [
      tauon
    ];

    services.playerctld.enable = true;
  };
}
