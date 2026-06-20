# y2OS — Build Instructions & GPL Compliance Document

> **Version:** 1.0  
> **Date:** 2026-06-18  
> **Maintainer:** YsFsystem  
> **Distribution Type:** Custom Linux From Scratch (LFS) Distribution  
> **SPDX Coverage:** GPL-2.0-only, GPL-2.0-or-later, GPL-3.0-or-later, MIT, ISC, BSD-2-Clause

---

## 1. Legal Preamble — License Compliance Statement

y2OS is an independently assembled Linux distribution that incorporates numerous open-source software components governed by a variety of licenses, most notably the **GNU General Public License (GPL) v2** and **v3**. In accordance with the obligations set forth in these licenses — particularly **GPL §3 (Source Code Distribution)** and **GPL §6 (Conveying Non-Source Forms)** — this document serves as the **written offer** and **technical blueprint** describing:

1. How each GPL-licensed component was obtained, configured, and compiled.
2. Where the corresponding **complete source code** can be retrieved.
3. How any user may **reproduce the identical binary artifacts** shipped in y2OS ISO images.

This offer is valid for a minimum of **three (3) years** from the date of each y2OS release.

---

## 2. System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        y2OS ISO Image                           │
│  Bootloader: Limine 12.1.0 (UEFI)                              │
│  Kernel:     Linux 7.0.3 (bzImage, built-in drivers)            │
│  Init:       BusyBox 1.36.1 init → /etc/init.d/rcS             │
│  Rootfs:     Alpine apk scaffold → cleaned → LFS-independent   │
│  Shell:      Zsh (via apk) + BusyBox ash fallback               │
│  Display:    Xorg 1.22 → DWM 6.5 (suckless, patched)           │
│  Audio:      PulseAudio + ALSA (alsa-utils via apk)             │
│  Networking: wpa_supplicant 2.10 + iwd/ell + BusyBox udhcpc    │
│  Pkg Mgmt:   Nix Daemon (user-space) + ypm (custom)            │
│  Privilege:  OpenDoas 6.8.2                                     │
└─────────────────────────────────────────────────────────────────┘
```

### 2.1 ypm (y2OS Package Manager) Directory Convention

Custom-compiled tools are installed under `/ypm/<package>/<version>/` within the rootfs:

| Path                        | Component       | Version |
|-----------------------------|-----------------|---------|
| `/ypm/dwm/6.5/bin/dwm`     | DWM (patched)   | 6.5     |
| `/ypm/xorg/1.22/bin/Xorg`  | Xorg wrapper    | 1.22    |
| `/ypm/xorg/1.22/lib/`      | Xorg libraries  | 1.22    |
| `/ypm/doas/6.8.2/bin/doas` | OpenDoas         | 6.8.2   |
| `/ypm/e2fsprogs/1.47.0/`   | mke2fs           | 1.47.0  |
| `/ypm/y2-install/1.0/`     | Installer script | 1.0     |
| `/ypm/ywifi/1.0/`          | Wi-Fi manager    | 1.0     |

---

## 3. Component Inventory & Source Code Locations

### 3.1 GPL-Licensed Components

| Component | Version | License | Upstream Source |
|-----------|---------|---------|----------------|
| Linux Kernel | 7.0.3 | GPL-2.0-only | https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.3.tar.xz |
| GRUB (ISO live boot) | 2.x | GPL-3.0-or-later | https://ftp.gnu.org/gnu/grub/ |
| BusyBox | 1.36.1 | GPL-2.0-only | https://busybox.net/downloads/busybox-1.36.1.tar.bz2 |
| GCC (host toolchain) | System | GPL-3.0-or-later | https://ftp.gnu.org/gnu/gcc/ |
| eudev (udevd/udevadm) | Alpine pkg | GPL-2.0-or-later | https://github.com/eudev-project/eudev |
| wpa_supplicant | 2.10 | GPL-2.0-only (dual BSD) | https://w1.fi/releases/wpa_supplicant-2.10.tar.gz |
| PulseAudio | Alpine pkg | GPL-2.0-or-later / LGPL-2.1 | https://www.freedesktop.org/software/pulseaudio/releases/ |
| alsa-utils | Alpine pkg | GPL-2.0-only | https://www.alsa-project.org/files/pub/utils/ |
| alsa-lib | Alpine pkg | LGPL-2.1-or-later | https://www.alsa-project.org/files/pub/lib/ |
| D-Bus | Alpine pkg | GPL-2.0-or-later | https://dbus.freedesktop.org/releases/dbus/ |
| GLib / GIO / GObject | 2.88.x | LGPL-2.1-or-later | https://gitlab.gnome.org/GNOME/glib |
| GTK 3 | 3.24.x | LGPL-2.1-or-later | https://gitlab.gnome.org/GNOME/gtk/-/tree/gtk-3-24 |
| GTK 4 | 4.22.x | LGPL-2.1-or-later | https://gitlab.gnome.org/GNOME/gtk |
| GStreamer (core + plugins) | 1.28.x | LGPL-2.1-or-later | https://gstreamer.freedesktop.org/src/ |
| Thunar (File Manager) | Alpine pkg | GPL-2.0-or-later | https://gitlab.xfce.org/xfce/thunar |
| XFCE4 Libraries (libxfce4util, libxfce4ui, xfconf, libxfce4panel) | Alpine pkg | GPL-2.0-or-later / LGPL-2.1 | https://gitlab.xfce.org/xfce/ |
| exo (XFCE helper library) | Alpine pkg | GPL-2.0-or-later | https://gitlab.xfce.org/xfce/exo |
| Polkit | Alpine pkg | GPL-2.0-or-later | https://gitlab.freedesktop.org/polkit/polkit |
| UDisks2 | Alpine pkg | GPL-2.0-or-later | https://github.com/storaged-project/udisks |
| GVFS | Alpine pkg | LGPL-2.1-or-later | https://gitlab.gnome.org/GNOME/gvfs |
| AppStream | Alpine pkg | LGPL-2.1-or-later | https://github.com/ximion/appstream |
| ncurses | Alpine pkg | MIT (X11) | https://ftp.gnu.org/gnu/ncurses/ |
| Zsh | Alpine pkg | MIT-like | https://sourceforge.net/projects/zsh/ |
| e2fsprogs | 1.47.0 | GPL-2.0-only | https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v1.47.0/ |

### 3.2 Permissive-Licensed Components

| Component | Version | License | Upstream Source |
|-----------|---------|---------|----------------|
| DWM | 6.5 (patched) | MIT/X | https://dl.suckless.org/dwm/ — repo: `src/dwm/` |
| dmenu | Alpine pkg | MIT/X | https://dl.suckless.org/tools/ |
| st (Simple Terminal) | Alpine pkg | MIT/X | https://dl.suckless.org/st/ |
| OpenDoas | 6.8.2 | ISC | https://github.com/Duncaen/OpenDoas/releases/tag/v6.8.2 |
| Xorg Server | 1.22 | MIT | https://www.x.org/releases/individual/xserver/ |
| Limine | 12.1.0 | BSD-2-Clause | https://github.com/limine-bootloader/limine/releases/tag/v12.1.0 |
| expat | 2.5.0 | MIT | https://github.com/libexpat/libexpat/releases/tag/R_2_5_0 |
| libnl | 3.7.0 | LGPL-2.1 | https://github.com/thom311/libnl/releases/tag/libnl3_7_0 |
| ell | Embedded | LGPL-2.1 | https://git.kernel.org/pub/scm/libs/ell/ell.git |

### 3.3 Special-Case: Nix Daemon

| Component | Version | License | Source |
|-----------|---------|---------|--------|
| Nix (nix-static) | Pre-built | LGPL-2.1-or-later | https://github.com/NixOS/nix |

Nix is deployed as a **statically-linked binary** (`/bin/nix-static`) with symlinks for all sub-commands (`nix`, `nix-build`, `nix-env`, `nix-shell`, `nix-store`, `nix-daemon`, etc.). The Nix store resides at `/nix/store/` and the daemon is started at boot via `/etc/init.d/rcS`.

### 3.4 Alpine apk Library Dependencies (Exhaustive)

The following libraries and tools are installed via `apk` during the scaffolding phase (Section 5). They are **runtime dependencies** of the components listed above. All are distributed as pre-compiled Alpine packages.

| Category | Components | License |
|----------|------------|---------|
| **C Library** | musl, musl-utils, ld-musl-x86_64 | MIT |
| **glibc Compat** | ld-linux-x86-64.so.2 (in `/lib64/`) | LGPL-2.1 |
| **Crypto / TLS** | GnuTLS, libgcrypt, libgpg-error, Nettle (hogweed), OpenSSL (libssl/libcrypto), p11-kit, libtasn1 | LGPL-2.1 / Apache-2.0 |
| **Kerberos** | MIT Kerberos 5 (libkrb5, libk5crypto, libgssapi_krb5, libkadm5, libkrad) | MIT |
| **Authentication** | Linux-PAM (libpam, libpam_misc, libpamc) | BSD-3-Clause |
| **Graphics Core** | Mesa (libGL, libEGL, libGLESv2, libgbm, gallium drivers), libdrm, pixman, Vulkan loader (libvulkan), libva (VA-API), LLVM 22 (Mesa backend) | MIT / Apache-2.0 |
| **X11 Libraries** | libX11, libXext, libXi, libXinerama, libXrandr, libXrender, libXcursor, libXcomposite, libXdamage, libXfixes, libXft, libXfont2, libXau, libXdmcp, libXtst, libXv, libXxf86vm, libxcb (+extensions), libxkbcommon, libxkbfile, xkbcomp, xkeyboard-config, libxshmfence, libxcvt, xcb-util | MIT / X11 |
| **Wayland** | libwayland-client, libwayland-cursor, libwayland-egl, gtk-layer-shell | MIT |
| **Input** | libinput, libevdev, libmtdev, tslib | MIT / LGPL-2.1 |
| **Font/Text** | fontconfig, FreeType, HarfBuzz (+gpu, +raster, +vector, +subset), Fribidi, Graphite2, Pango (+Cairo, +FT2, +Xft), fontenc | MIT / FTL / LGPL-2.1 |
| **Image** | libpng, libjpeg-turbo, libtiff, libwebp, OpenEXR (libIlm*, libImath), libdeflate, gdk-pixbuf, librsvg, glycin, openjpeg | Various permissive |
| **Audio/Video Codecs** | FLAC, libogg, libvorbis (+enc, +file), Opus, SpeexDSP, libsndfile, SoundTouch, MP3 LAME, mpg123, fdk-aac, FAAC/FAAD2, aom (AV1), dav1d, SVT-AV1, x265 (HEVC), openh264, libtheora, libmodplug, GSM, Flite (TTS) | Various (GPL/LGPL/BSD) |
| **Media** | libdvdcss, libdvdread, libdvdnav, libbluray, libdc1394, libraw1394, OpenAL, SBC, LDAC | GPL-2.0 / LGPL-2.1 |
| **Networking** | libcurl, nghttp2, libcares, libpsl, libidn2, Avahi (client/common), neon, libsoup 3, librtmp, libsrt, libsrtp2 | MIT / LGPL-2.1 |
| **GNOME Stack** | GNOME Keyring (gnome-keyring-daemon), GCR 3/4, libsecret, GNOME Online Accounts (libgoa), json-glib, libnotify, libadwaita, GObject Introspection (libgirepository), libgtop, librest, libxmlb | LGPL-2.1 / GPL-2.0 |
| **Desktop** | AT-SPI2 (at-spi2-registryd, libatspi), startup-notification, desktop-file-utils, update-mime-database | LGPL-2.1 |
| **System** | libseccomp, kmod (libkmod), libcap, libcap-ng, libuuid, libblkid, libmount, libeconf, elfutils (libelf), libbsd, libmd, s6/skarnet (libutmps, libskarnet), bubblewrap (bwrap) | LGPL-2.1 / BSD |
| **Compression** | zlib, zstd, bzip2, lzma/xz, brotli (enc/dec/common), lzo | MIT / BSD / GPL-2.0 |
| **XML/Data** | libxml2, libexpat, libfyaml, SQLite3 | MIT |
| **Misc** | DirectFB, libexif, zbar, CUPS (libcups, libcupsimage), graphene, libepoxy, GMP, libunistring, libunibreak, libltdl, libpciaccess, libusb, pkgconf | Various permissive |
| **Compiler Runtime** | libstdc++ (GCC), libgcc_s, libgomp | GPL-3.0 (runtime exception) |
| **SPIRV** | SPIRV-Tools (+opt, +link, +lint, +reduce, +diff) | Apache-2.0 |
| **Data** | kbd, kbd-bkeymaps, tzdata (zoneinfo), X11 bitmap fonts (misc, cyrillic) | Public Domain / MIT |

---

## 4. Kernel Build Procedure (Linux 7.0.3)

### 4.1 Obtaining the Source

```bash
wget https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.3.tar.xz
tar xf linux-7.0.3.tar.xz
cd linux-7.0.3
```

### 4.2 Configuration

The kernel `.config` file used for y2OS is located in the repository at:

```
src/linux-7.0.3/.config
```

Users wishing to reproduce the build **MUST** use this exact configuration file. The following hardware-critical options were enabled as **built-in (=y)** using the `scripts/config` tool:

```bash
# I2C Bus Support (Touchpad, Sensor HID)
scripts/config --enable CONFIG_I2C

# ACPI Platform (Power Management, Fan, Battery)
scripts/config --enable CONFIG_ACPI

# Multitouch HID (Touchscreen, Trackpad gestures)
scripts/config --enable CONFIG_HID_MULTITOUCH

# Intel HD Audio (snd-hda-intel, ich9 codec family)
scripts/config --enable CONFIG_SND_HDA_INTEL

# Universal Input Layer (evdev — keyboard, mouse, touchpad)
scripts/config --enable CONFIG_INPUT_EVDEV
```

These drivers are compiled **directly into the kernel image** (`=y`), not as loadable modules (`=m`). This eliminates the need for an initramfs or module-loading infrastructure at boot time.

#### Verified `.config` Values

```
CONFIG_I2C=y
CONFIG_ACPI=y
CONFIG_HID_MULTITOUCH=y
CONFIG_SND_HDA_INTEL=y
CONFIG_INPUT_EVDEV=y
```

### 4.3 Compilation

```bash
make -j$(nproc)
```

The resulting `bzImage` is located at:

```
arch/x86/boot/bzImage
```

This file is copied to:

```
rootfs/boot/bzImage
iso_root/boot/bzImage
```

### 4.4 Reproducing the Kernel

```bash
cp /path/to/y2os-repo/src/linux-7.0.3/.config .config
make olddefconfig
make -j$(nproc)
# Output: arch/x86/boot/bzImage
```

---

## 5. Root Filesystem Construction (Alpine apk Scaffolding)

### 5.1 Methodology

y2OS employs an **isolated scaffolding** technique: a Docker container running `alpine:edge` is used as a **transient build host** to bootstrap the root filesystem. This method ensures reproducibility and prevents host-system contamination.

> **Important:** Alpine Linux itself is NOT part of y2OS. Alpine's `apk` package manager is used solely as a cross-installation tool during the build phase. All Alpine-specific identity files are purged after installation.

### 5.2 Build Steps

#### Step 1 — Launch Isolated Build Environment

```bash
docker run -it --rm -v $(pwd)/rootfs:/target alpine:edge /bin/sh
```

#### Step 2 — Install Base Packages to Target Rootfs

```bash
apk add --root /target --initdb \
    busybox \
    busybox-suid \
    musl \
    musl-utils \
    ncurses \
    ncurses-terminfo-base \
    alsa-utils \
    alsa-lib \
    pulseaudio \
    pulseaudio-utils \
    dbus \
    dbus-libs \
    eudev \
    eudev-libs \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    ca-certificates \
    linux-firmware \
    kbd \
    kbd-bkeymaps \
    libinput \
    libinput-libs \
    xkbcomp \
    xkeyboard-config \
    fontconfig \
    freetype \
    libxft \
    libx11 \
    libxext \
    libxinerama \
    libxrandr \
    libxi \
    pixman \
    mesa-dri-gallium \
    mesa-gl \
    mesa-egl \
    mesa-gbm \
    xf86-input-libinput \
    xinit \
    xauth \
    libpciaccess
```

> The `--root /target` flag instructs `apk` to install packages into the y2OS rootfs directory, NOT into the container's own filesystem.

#### Step 3 — Purge Alpine Identity (LFS Independence)

After all packages are installed, **all traces of Alpine's package manager** are removed:

```bash
# Remove apk database, cache, and identity
rm -rf /target/etc/apk
rm -rf /target/var/cache/apk
rm -rf /target/lib/apk
rm -rf /target/etc/alpine-release
rm -rf /target/etc/issue
rm -f  /target/etc/motd

# Remove package manager logs
rm -rf /target/var/log/*
```

This ensures y2OS operates as a **fully independent** Linux distribution with no runtime dependency on Alpine or apk.

### 5.3 Rationale

This approach is analogous to **debootstrap** (Debian) or **pacstrap** (Arch), but uses Alpine's minimal musl-based packages for a smaller footprint. The key distinction is that y2OS **scrubs all scaffolding artifacts**, making the final system a standalone LFS distribution.

### 5.4 External Data & Certificates

In addition to the packages installed via `apk`, two categories of **externally sourced data** are copied into the y2OS rootfs during the build process. These assets are **not compiled from source** and carry their own distinct licensing terms.

#### 5.4.1 SSL/TLS Root Certificates (`ca-certificates`)

The Nix daemon, `wpa_supplicant`, and other network-facing utilities require a trusted root certificate store to establish TLS connections. y2OS ships a copy of the **Mozilla CA Certificate Bundle**, which was obtained from the build host (Arch Linux) at the following path:

```
Host:   /etc/ssl/certs/ca-certificates.crt
Target: rootfs/etc/ssl/certs/ca-certificates.crt
```

The certificate bundle is referenced system-wide via the `NIX_SSL_CERT_FILE` environment variable:

```bash
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
```

**Licensing:**

> The root certificates included in this bundle are part of the [Mozilla CA Certificate Program](https://wiki.mozilla.org/CA). The extraction and distribution of these certificates is governed by the **Mozilla Public License 2.0 (MPL-2.0)**.
>
> MPL-2.0 is a **file-level copyleft** license that permits free redistribution of the certificate data — both in source and compiled form — provided that any modifications to the *licensed files themselves* are made available under the same MPL-2.0 terms. Merely bundling unmodified certificate files (as y2OS does) imposes **no additional licensing obligations** on the rest of the distribution.
>
> - **SPDX Identifier:** `MPL-2.0`
> - **Full License Text:** https://www.mozilla.org/en-US/MPL/2.0/
> - **Mozilla CA Policy:** https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/policy/

y2OS distributes these certificates **unmodified**. No alteration has been made to the certificate data or the trust chain.

#### 5.4.2 Hardware Firmware Blobs (`linux-firmware`)

To ensure broad hardware compatibility — particularly for **Wi-Fi chipsets** (Intel, Realtek, MediaTek, Qualcomm/Atheros) and **touchscreen/trackpad controllers** — y2OS includes binary firmware files sourced from the upstream `linux-firmware` repository:

```
Source: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
Target: rootfs/lib/firmware/
```

These firmware files are also available via the `linux-firmware` Alpine package installed during the scaffolding phase (Section 5.2).

> [!CAUTION]
> **PROPRIETARY LICENSE NOTICE**
>
> The firmware files distributed under `/lib/firmware/` are **NOT free/open-source software**. They are proprietary binary blobs provided by their respective hardware vendors under **vendor-specific, restrictive licenses**. These files are explicitly **outside the scope of the GPL** and are not covered by the GPL license of the Linux kernel or any other GPL-licensed component in y2OS.
>
> Each firmware file's individual licensing terms are documented in the `WHENCE` file located at the root of the `linux-firmware` repository:
>
> - **WHENCE file:** https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/WHENCE
> - **Local copy:** `src/linux-firmware/WHENCE` (if present in the repository)
>
> **Common vendor license terms include (but are not limited to):**
>
> | Vendor | Typical Firmware Prefix | License Type |
> |--------|------------------------|--------------|
> | Intel | `iwlwifi-*`, `i915/*` | Intel Redistributable, no modification permitted |
> | Realtek | `rtl_nic/*`, `rtlwifi/*`, `rtw88/*`, `rtw89/*` | Realtek Redistributable, binary-only |
> | Qualcomm/Atheros | `ath10k/*`, `ath11k/*` | Qualcomm Redistributable, no reverse-engineering |
> | MediaTek | `mediatek/*` | MediaTek Redistributable |
> | AMD | `amdgpu/*`, `radeon/*` | AMD Redistributable, no modification |
>
> **General restrictions that apply to most firmware blobs:**
> 1. Redistribution of the **unmodified binary** is permitted.
> 2. **Reverse engineering, decompilation, and modification** are explicitly prohibited.
> 3. Firmware files may **not** be sold independently; they may only be distributed alongside compatible hardware or software drivers.
> 4. No **source code** is available or required to be provided for these files.
>
> **By using y2OS, you acknowledge that the firmware files in `/lib/firmware/` are subject to their respective vendor licenses, NOT the GPL. y2OS redistributes these files in compliance with each vendor's redistribution terms as specified in the WHENCE file.**

Users who wish to build a **fully free** (as in freedom) y2OS variant may omit the `linux-firmware` package during the scaffolding phase and remove the `/lib/firmware/` directory from the rootfs. Note that this will result in **non-functional Wi-Fi, Bluetooth, and potentially GPU acceleration** on most modern hardware.

---

## 6. Custom-Compiled Components

### 6.1 DWM (Dynamic Window Manager) — v6.5

- **License:** MIT/X Consortium
- **Source:** `src/dwm/` (includes autostart patch: `dwm-autostart-20210120-cb3f58a.diff`)
- **Upstream:** https://dl.suckless.org/dwm/

```bash
cd src/dwm
# config.h contains y2OS-specific customizations
make clean
make CC=cc LDFLAGS="-lX11 -lXext -lXinerama -lfontconfig -lXft"
# Binary installed to: rootfs/ypm/dwm/6.5/bin/dwm
cp dwm /path/to/rootfs/ypm/dwm/6.5/bin/dwm
```

The DWM window manager is launched via `~/.xinitrc`:
```bash
exec /ypm/dwm/6.5/bin/dwm
```

### 6.2 Xorg Server — v1.22

- **License:** MIT
- **Source:** `src/xserver/` (Xorg server source with meson build)
- **Upstream:** https://www.x.org/releases/individual/xserver/

The Xorg server binary is compiled with meson and installed into the rootfs:

```bash
cd src/xserver
meson setup build --prefix=/usr
ninja -C build
DESTDIR=/path/to/rootfs ninja -C build install
```

The wrapper script at `/ypm/xorg/1.22/bin/Xorg` delegates to `/usr/libexec/Xorg`:

```bash
#!/bin/sh
basedir="/usr/libexec"
if [ -x "$basedir"/Xorg.wrap ]; then
    exec "$basedir"/Xorg.wrap "$@"
else
    exec "$basedir"/Xorg "$@"
fi
```

Xorg requires SUID root privileges, set during installation:
```bash
chmod 4755 /ypm/xorg/1.22/bin/Xorg
```

### 6.3 OpenDoas — v6.8.2

- **License:** ISC
- **Source:** `src/opendoas-6.8.2/`
- **Upstream:** https://github.com/Duncaen/OpenDoas

```bash
cd src/opendoas-6.8.2
./configure --prefix=/ypm/doas/6.8.2
make
# Binary installed to: rootfs/ypm/doas/6.8.2/bin/doas
cp doas /path/to/rootfs/ypm/doas/6.8.2/bin/doas
chmod 4755 /path/to/rootfs/ypm/doas/6.8.2/bin/doas
```

Configuration (`/etc/doas.conf`):
```
permit :wheel
```

### 6.4 wpa_supplicant — v2.10

- **License:** GPL-2.0-only (dual BSD)
- **Source:** `src/wpa_supplicant-2.10/`
- **Upstream:** https://w1.fi/releases/wpa_supplicant-2.10.tar.gz

```bash
cd src/wpa_supplicant-2.10/wpa_supplicant
cp defconfig .config
make
make install DESTDIR=/path/to/rootfs
```

### 6.5 BusyBox — v1.36.1

- **License:** GPL-2.0-only
- **Source:** `src/busybox-1.36.1/`
- **Upstream:** https://busybox.net/downloads/busybox-1.36.1.tar.bz2

BusyBox provides core POSIX utilities (`sh`, `mount`, `init`, `getty`, `ifconfig`, `udhcpc`, etc.) as a single statically-linked multicall binary.

```bash
cd src/busybox-1.36.1
make defconfig  # or: cp /path/to/.config .
make -j$(nproc)
make install CONFIG_PREFIX=/path/to/rootfs
chmod 4755 /path/to/rootfs/bin/busybox
```

### 6.6 e2fsprogs — v1.47.0

- **License:** GPL-2.0-only
- **Source:** `src/e2fsprogs-1.47.0/`
- **Upstream:** https://sourceforge.net/projects/e2fsprogs/

```bash
cd src/e2fsprogs-1.47.0
./configure --prefix=/usr
make
# Only mke2fs is installed for y2OS:
cp build/misc/mke2fs /path/to/rootfs/ypm/e2fsprogs/1.47.0/mke2fs
```

### 6.7 Limine Bootloader — v12.1.0

- **License:** BSD-2-Clause
- **Source:** `src/limine-12.1.0/`
- **Upstream:** https://github.com/limine-bootloader/limine

The UEFI bootloader binary (`BOOTX64.EFI`) is installed to:
```
rootfs/boot/BOOTX64.EFI
iso_root/boot/BOOTX64.EFI → EFI/BOOT/BOOTX64.EFI
```

### 6.8 libnl — v3.7.0 & ell (Embedded Linux Library)

- **Source:** `src/libnl-3.7.0/`, `src/ell/`
- **Purpose:** Dependencies for wpa_supplicant and iwd networking stack

### 6.9 expat — v2.5.0

- **License:** MIT
- **Source:** `src/expat-2.5.0/`
- **Purpose:** XML parsing library (dependency for D-Bus, Xorg)

### 6.10 Nix Daemon

- **License:** LGPL-2.1-or-later
- **Upstream:** https://github.com/NixOS/nix
- **Installation:** Pre-built Nix binaries are deployed to `/nix/` within the rootfs
- **Boot integration:** Started via `/etc/init.d/rcS` during system initialization

---

## 7. ISO Image Assembly

### 7.1 Dual Boot Chain

y2OS uses **two distinct boot methods** depending on context:

#### A) ISO Live Boot — GRUB 2 (GPL-3.0-or-later)

The ISO image (`y2OS_yeni.iso`) uses **GRUB** to boot a live environment with an initramfs:

```
BIOS/UEFI Firmware
  └─→ GRUB 2 (iso_root/boot/grub/grub.cfg)
       └─→ /boot/vmlinuz      (Linux 7.0.3 bzImage)
       └─→ /boot/initrd.img   (gzip compressed initramfs containing rootfs)
            └─→ /sbin/init (BusyBox init)
                 └─→ /etc/init.d/rcS
```

**GRUB configuration** (`iso_root/boot/grub/grub.cfg`):

```
set timeout=5
set default=0

menuentry "y2OS by YsFsystem" {
    echo "Booting Kernel"
    linux /boot/vmlinuz console=tty1 loglevel=7 earlyprintk=efi
    echo "Loading initramfs into RAM"
    initrd /boot/initrd.img
}
```

> **Note:** GRUB is licensed under **GPL-3.0-or-later**. Source code: https://ftp.gnu.org/gnu/grub/

#### B) Installed System Boot — Limine 12.1.0 (BSD-2-Clause)

After `y2-install` writes y2OS to disk, the installed system boots via **Limine UEFI**:

```
UEFI Firmware
  └─→ EFI/BOOT/BOOTX64.EFI  (Limine 12.1.0)
       └─→ EFI/BOOT/limine.conf
            └─→ EFI/BOOT/bzImage  (Linux 7.0.3)
                 └─→ rootfs (ext4, on-disk)
                      └─→ /sbin/init (BusyBox init)
                           └─→ /etc/init.d/rcS
```

### 7.2 Limine Configuration (Installed System)

```
timeout: 3

/y2OS by YsFsystem (UEFI)
    protocol: linux
    kernel_path: boot():/EFI/BOOT/bzImage
    cmdline: root=PARTUUID=<uuid> rw rootwait devtmpfs.mount=1 init=/sbin/init console=tty1 loglevel=7 rootfstype=ext4
```

### 7.3 Init Sequence

The boot process follows this order:

1. **BusyBox init** reads `/etc/inittab`
2. `::sysinit:/etc/init.d/rcS` — mounts virtual filesystems, starts `udevd`
3. `tty1::respawn:/sbin/getty` — spawns login terminals
4. User login → Zsh → `~/.zprofile` → `startx` (on tty1)
5. `~/.xinitrc` → PulseAudio → DWM

---

## 8. Installation Process (`y2-install`)

The installer script at `/ypm/y2-install/1.0/y2-install` performs:

1. **Disk partitioning** — GPT/MBR via `fdisk` (EFI + root)
2. **Filesystem creation** — FAT32 (EFI) + ext4 (root) via `mkfs.vfat` and `mke2fs`
3. **Rootfs cloning** — `cp -a` of live system directories
4. **Bootloader setup** — Limine UEFI configuration
5. **User creation** — `adduser`, `chpasswd`, group assignments
6. **Service configuration** — D-Bus, Nix daemon, keyboard layout
7. **Privilege setup** — SUID bits for BusyBox, Xorg, doas

---

## 9. Obtaining Complete Source Code

### 9.1 Repository Sources

All custom-compiled source code is available in the `src/` directory of this repository:

```
src/
├── busybox-1.36.1/          # GPL-2.0
├── dwm/                     # MIT (with autostart patch)
├── e2fsprogs-1.47.0/        # GPL-2.0
├── ell/                     # LGPL-2.1
├── expat-2.5.0/             # MIT
├── libnl-3.7.0/             # LGPL-2.1
├── limine-12.1.0/           # BSD-2-Clause
├── linux-7.0.3/             # GPL-2.0 (includes .config)
├── linux-firmware/           # Mixed (see WHENCE file)
├── opendoas-6.8.2/          # ISC
├── wpa_supplicant-2.10/     # GPL-2.0 (dual BSD)
├── xserver/                 # MIT
└── ypm/                     # y2OS custom (proprietary scripts)
```

### 9.2 Alpine apk Packages

Packages installed via `apk` during the scaffolding phase can be obtained from:

```
https://dl-cdn.alpinelinux.org/alpine/edge/main/
https://dl-cdn.alpinelinux.org/alpine/edge/community/
```

Key packages and their source repositories:

| Package | Source |
|---------|--------|
| musl | https://musl.libc.org/ |
| alsa-utils | https://www.alsa-project.org/ |
| alsa-lib | https://www.alsa-project.org/ |
| pulseaudio | https://www.freedesktop.org/wiki/Software/PulseAudio/ |
| dbus | https://dbus.freedesktop.org/ |
| eudev | https://github.com/eudev-project/eudev |
| ncurses | https://invisible-island.net/ncurses/ |
| zsh | https://www.zsh.org/ |
| fontconfig | https://www.freedesktop.org/wiki/Software/fontconfig/ |
| freetype | https://freetype.org/ |
| libX11 | https://www.x.org/ |
| mesa | https://mesa3d.org/ |
| pixman | https://pixman.org/ |
| libinput | https://www.freedesktop.org/wiki/Software/libinput/ |
| ca-certificates | https://packages.debian.org/sid/ca-certificates |

### 9.3 Written Offer for Source Code

In compliance with GPL v2 §3(b) and GPL v3 §6(b):

> We hereby offer, valid for at least three years from the date of each y2OS release, to provide any third party, for a charge no more than the cost of physically performing source distribution, a complete machine-readable copy of the corresponding source code for all GPL-licensed software included in y2OS, on a medium customarily used for software interchange.
>
> Requests may be submitted via the project's GitHub Issues page or by contacting the maintainer directly.

---

## 10. Modification & Redistribution Guide

### 10.1 For End Users

To rebuild y2OS from source:

```bash
# 1. Clone the repository
git clone https://github.com/<username>/y2-os.git
cd y2-os

# 2. Build the kernel
cd src/linux-7.0.3
cp .config .config.backup
make olddefconfig
make -j$(nproc)
cp arch/x86/boot/bzImage ../../rootfs/boot/bzImage

# 3. Scaffold the rootfs (requires Docker)
docker run -it --rm -v $(pwd)/rootfs:/target alpine:edge /bin/sh
# (run apk commands from Section 5.2 inside the container)

# 4. Compile custom tools
cd src/dwm && make && cp dwm ../../rootfs/ypm/dwm/6.5/bin/
cd src/opendoas-6.8.2 && ./configure && make && cp doas ../../rootfs/ypm/doas/6.8.2/bin/
# ... (repeat for each component)

# 5. Generate ISO
# (use xorriso or similar tool to create bootable UEFI ISO)
```

### 10.2 For Redistributors

If you redistribute y2OS (modified or unmodified), you **MUST**:

1. **Include this document** (or an equivalent written offer) with every distribution.
2. **Provide source code** for all GPL-licensed components, either bundled or via written offer.
3. **Preserve all copyright notices** and license texts.
4. **Clearly mark modifications** if you alter any GPL-licensed component.
5. **License derivative works** of GPL components under the same GPL version.

---

## 11. File Checksums & Verification

Key binary artifacts in the y2OS rootfs:

| File | Type | Description |
|------|------|-------------|
| `rootfs/boot/bzImage` | Kernel | Linux 7.0.3 compressed kernel image |
| `rootfs/boot/BOOTX64.EFI` | Bootloader | Limine 12.1.0 UEFI stub |
| `rootfs/bin/busybox` | Multicall | BusyBox 1.36.1 (SUID) |
| `rootfs/usr/libexec/Xorg` | Server | Xorg 1.22 display server |
| `rootfs/ypm/dwm/6.5/bin/dwm` | WM | DWM 6.5 (patched) |
| `rootfs/ypm/doas/6.8.2/bin/doas` | Privilege | OpenDoas 6.8.2 (SUID) |

---

## 12. Contact & Source Requests

- **GitHub Repository:** *(insert URL upon publication)*
- **Kernel .config location:** `src/linux-7.0.3/.config`
- **Issue Tracker:** GitHub Issues
- **Source Code Requests:** Open a GitHub Issue titled "GPL Source Request"

---

*This document satisfies the source code disclosure and build instruction requirements of the GNU General Public License v2 (§3) and v3 (§6). All information is accurate as of the date shown above. For questions regarding licensing, please contact the project maintainer.*
