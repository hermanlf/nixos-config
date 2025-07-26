# nixos-config/modules/home/keeper.nix
{
  pkgs,
  lib,
  ...
}:

let
  keeper-password-manager = pkgs.stdenv.mkDerivation rec {
    pname = "keeper-password-manager";
    version = "17.3.0";

    src = pkgs.fetchurl {
      url = "https://keepersecurity.com/desktop_electron/Linux/repo/deb/keeperpasswordmanager_${version}_amd64.deb";
      hash = "sha256-7tP+G7ECZcpqy+dt5JByegzos4bVLAf9YVGyCIc2Qzs=";
    };

    nativeBuildInputs = with pkgs; [
      dpkg
      wrapGAppsHook
      autoPatchelfHook
    ];

    buildInputs = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libappindicator-gtk3
      libdbusmenu
      libdrm
      libnotify
      libpulseaudio
      libsecret
      libuuid
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      pango
      systemd
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXtst
      xorg.libxcb
      xorg.libxshmfence
      zlib
      vips  # Provides libvips-cpp.so.42
    ];

    runtimeDependencies = with pkgs; [
      libsecret
      libnotify
    ];

    unpackPhase = ''
      runHook preUnpack
      # Extract without preserving permissions to avoid setuid issues
      ar x $src
      tar xf data.tar.xz --no-same-owner --no-same-permissions
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      
      mkdir -p $out/bin
      mkdir -p $out/share
      
      # Copy application files
      cp -r usr/lib/keeperpasswordmanager $out/share/
      
      # Copy desktop file and icons if they exist
      if [ -d "usr/share/applications" ]; then
        cp -r usr/share/applications $out/share/
      fi
      if [ -d "usr/share/pixmaps" ]; then
        cp -r usr/share/pixmaps $out/share/
      fi
      if [ -d "usr/share/icons" ]; then
        cp -r usr/share/icons $out/share/
      fi
      
      # Find the actual executable name
      EXEC_NAME="keeper-password-manager"
      if [ -f "$out/share/keeperpasswordmanager/keeperpasswordmanager" ]; then
        EXEC_NAME="keeperpasswordmanager"
      fi
      
      # Create wrapper script
      cat > $out/bin/keeper-password-manager << EOF
  #!/bin/sh
  exec $out/share/keeperpasswordmanager/$EXEC_NAME "\$@"
  EOF
      chmod +x $out/bin/keeper-password-manager
      
      # Create symlinks for common names
      ln -s $out/bin/keeper-password-manager $out/bin/keeper
      ln -s $out/bin/keeper-password-manager $out/bin/keeperpasswordmanager
      
      runHook postInstall
    '';

    postFixup = ''
      # Configure auto-patchelf to ignore optional musl dependency
      export NIXPKGS_ALLOW_UNFREE=1
      
      # Fix desktop file exec path if it exists
      if [ -f "$out/share/applications/keeper-password-manager.desktop" ]; then
        substituteInPlace $out/share/applications/keeper-password-manager.desktop \
          --replace "/usr/lib/keeperpasswordmanager/keeper-password-manager" "$out/bin/keeper-password-manager"
      fi
      
      # Also check for other possible desktop file names
      if [ -f "$out/share/applications/keeperpasswordmanager.desktop" ]; then
        substituteInPlace $out/share/applications/keeperpasswordmanager.desktop \
          --replace "/usr/lib/keeperpasswordmanager/keeper-password-manager" "$out/bin/keeper-password-manager" \
          --replace "/usr/lib/keeperpasswordmanager/keeperpasswordmanager" "$out/bin/keeper-password-manager"
      fi
    '';

    # Configure auto-patchelf to ignore missing musl dependency
    autoPatchelfIgnoreMissingDeps = [
      "libc.musl-x86_64.so.1"
    ];

    meta = with lib; {
      description = "Keeper Password Manager - Secure digital vault for protecting and managing passwords";
      homepage = "https://www.keepersecurity.com";
      license = licenses.unfree;
      maintainers = [ ];
      platforms = [ "x86_64-linux" ];
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    };
  };
in
{
  home.packages = [ keeper-password-manager ];
}
