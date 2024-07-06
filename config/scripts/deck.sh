#!/usr/bin/env bash

set -oue pipefail

STEAM_PACKAGE_VERSION="${STEAM_PACKAGE_VERSION:-steam-jupiter-stable-1.0.0.79-1-x86_64}"

git clone https://gitlab.com/evlaV/jupiter-dock-updater-bin.git --depth 1 /tmp/jupiter-dock-updater-bin
mv -v /tmp/jupiter-dock-updater-bin/packaged/usr/lib/jupiter-dock-updater /usr/libexec/jupiter-dock-updater
rm -rf /tmp/jupiter-dock-updater-bin
ln -s /usr/bin/steamos-logger /usr/bin/steamos-info
ln -s /usr/bin/steamos-logger /usr/bin/steamos-notice
ln -s /usr/bin/steamos-logger /usr/bin/steamos-warning

curl -Lo /tmp/steam-jupiter.pkg.tar.zst https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/"${STEAM_PACKAGE_VERSION}".pkg.tar.zst
mkdir -p /usr/etc/first-boot
tar --no-same-owner --no-same-permissions --no-overwrite-dir -I zstd -xvf /tmp/steam-jupiter.pkg.tar.zst usr/lib/steam/bootstraplinux_ubuntu12_32.tar.xz -o > /usr/etc/first-boot/bootstraplinux_ubuntu12_32.tar.xz
rm -f /tmp/steam-jupiter.pkg.tar.zst

mkdir -p "/usr/etc/xdg/autostart"
mv "/usr/etc/skel/.config/autostart/steam.desktop" "/usr/etc/xdg/autostart/steam.desktop"
sed -i 's@Exec=waydroid first-launch@Exec=/usr/bin/waydroid-launcher first-launch\nX-Steam-Library-Capsule=/usr/share/applications/Waydroid/capsule.png\nX-Steam-Library-Hero=/usr/share/applications/Waydroid/hero.png\nX-Steam-Library-Logo=/usr/share/applications/Waydroid/logo.png\nX-Steam-Library-StoreCapsule=/usr/share/applications/Waydroid/store-logo.png\nX-Steam-Controller-Template=Desktop@g' /usr/share/applications/Waydroid.desktop
