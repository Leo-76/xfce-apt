# xfce-apt : depot apt de kits macOS pour XFCE

Paquets : `xfce-macos-1`, `xfce-macos-2`, `xfce-macos-3`. Chacun installe une commande `/usr/bin/xfce-macos-N`
(`info | fetch | install | remove`). Aucun fichier d'original n'est embarque : ils sont telecharges a l'usage.

Depot NON signe (pas de cle GPG), donc `trusted=yes` :

    echo "deb [trusted=yes] https://leo-76.github.io/xfce-apt ./" | sudo tee /etc/apt/sources.list.d/leo.list
    sudo apt update && sudo apt install xfce-macos-1 xfce-macos-2 xfce-macos-3

Teste : construction sur Debian, `apt-get install` / `remove` des 3 paquets depuis une source `file:`.
Non teste : via HTTP (Pages), signature GPG, rendu sous XFCE.
