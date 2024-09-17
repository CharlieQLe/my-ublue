post-setup:
    #!/usr/bin/env bash
    flatpak --user override --filesystem=xdg-config/gtk-3.0:ro
    flatpak --user override --filesystem=xdg-config/gtk-4.0:ro
    flatpak --user override --filesystem=xdg-data/themes:ro
    flatpak --user override --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
    flatpak --user override --env=MOZ_DBUS_REMOTE=1
    flatpak --user override --env=FLATPAK_ENABLE_SDK_EXT=* com.visualstudio.code
    mkdir -p ~/.local/bin
    cp /usr/etc/my-ublue/podman-host ~/.local/bin/podman-host
    chmod +x ~/.local/bin/podman-host

setup-gaming:
    #!/usr/bin/env bash
    flatpak --user override --filesystem=xdg-config/MangoHud:ro com.valvesoftware.Steam
    flatpak --user override --filesystem=~/.var/app/com.valvesoftware.Steam/data/Steam com.usebottles.bottles
    mkdir -p ~/.config/MangoHud
    cp /usr/etc/my-ublue/MangoHud.conf ~/.config/MangoHud
    rpm-ostree kargs --append-if-missing=amdgpu.ppfeaturemask=0xffffffff --append-if-missing=amdgpu.gpu_recovery=1
    sudo usermod -a -G gamemode "$USER"
