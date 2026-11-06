#!/bin/sh
# Construit les .deb (xfce-skinpack, xfce-smallsur, xfce-ventura) et l'index apt (depot plat).
# usage : sh build-deb.sh SRC_XPKG SORTIE
set -eu
SRC=$1; OUT=$2; mkdir -p "$OUT"; W=$(mktemp -d)
build() { # nom version depends description script-source
  d=$W/$1; mkdir -p "$d/DEBIAN" "$d/usr/bin"
  install -m 755 "$5" "$d/usr/bin/$1"
  cat >"$d/DEBIAN/control" <<EOF
Package: $1
Version: $2
Section: x11
Priority: optional
Architecture: all
Depends: $3
Maintainer: Leo-76 <leo-76@users.noreply.github.com>
Description: $4
 Le paquet n'embarque aucun fichier de l'original : la commande $1
 telecharge la version figee de l'original (info | fetch | install | remove).
EOF
  dpkg-deb --root-owner-group --build "$d" "$OUT/$1_$2_all.deb" >/dev/null
}
while IFS='|' read -r n v _ dep d; do
  build "$n" "0.1+$v" "$(echo "$dep" | sed 's/,/, /g; s/\bxz\b/xz-utils/')" "$d" "$SRC/pkgs/$n"
done <"$SRC/index"
cd "$OUT"; dpkg-scanpackages . /dev/null 2>/dev/null | gzip -9 >Packages.gz
dpkg-scanpackages . /dev/null 2>/dev/null >Packages
apt-ftparchive release . >Release
rm -rf "$W"; ls -l
