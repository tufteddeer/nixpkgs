{ lib
, stdenv
, fetchurl
, gettext
, gnome
, libgtop
, gtk4
, libadwaita
, pcre2
, vte-gtk4
, desktop-file-utils
, meson
, ninja
, pkg-config
, wrapGAppsHook4
, nixosTests
}:

stdenv.mkDerivation rec {
  pname = "gnome-console";
  version = "45.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-console/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "50YhKNLfIySh10gGLEBCnNBQSvCeQHBnsz86nQxZyOE=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    libgtop
    gtk4
    libadwaita
    pcre2
    vte-gtk4
  ];

  passthru = {
    updateScript = gnome.updateScript {
      packageName = "gnome-console";
    };
  };

  passthru.tests.test = nixosTests.terminal-emulators.kgx;

  meta = with lib; {
    description = "Simple user-friendly terminal emulator for the GNOME desktop";
    homepage = "https://gitlab.gnome.org/GNOME/console";
    license = licenses.gpl3Plus;
    maintainers = teams.gnome.members ++ (with maintainers; [ zhaofengli ]);
    platforms = platforms.unix;
  };
}
