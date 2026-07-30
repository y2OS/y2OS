Language: [English](#english) | Dil: [Türkçe](#türkçe)

---

# English

# y2OS Operating System

y2OS is an independent Linux distribution. It is not based on any existing distribution.

## Core Features

**Non-Systemd** Get higher performance without Systemd, and stay true to the Unix philosophy.

**ypm package manager** Unlike mainstream package managers, it does not use system directories like `/usr/bin` directly; it provides static packages under `/ypm`.

**Driver support** The Linux Firmware package comes pre-installed inside the ISO.

**Wiki** To get detailed information about installation and usage, visit our wiki page by clicking [here](https://github.com/y2OS/y2OS/wiki).

**Forum** For all kinds of questions, bug reports, and ideas, visit our forum by clicking [here](https://github.com/orgs/y2OS/discussions/categories).

**+100,000 packages** Can be installed via Nix Store.

## Main Components

y2OS contains many open-source tools out of the box. Our core components:

| Component | Software |
| --- | --- |
| Bootloader | Limine *(Grub in Live ISO)* |
| Init & Userland | BusyBox Init & BusyBox Tools |
| Service Manager | yservice *(ISO v1.1.0 and later)* |
| Package Management | ypm & Nix Store |
| Window Manager | DWM (Dynamic Window Manager) |
| Default Shell | Zsh *(BusyBox in Live TTY)* |
| Audio Architecture | PulseAudio & AlsaMixer |
| Network Management | wpa_supplicant & ywifi |

## Projects Developed for y2OS

- [Our main GitHub organization](https://github.com/y2OS)
  
- [ypm package manager](https://github.com/y2OS/ypm)
  
- [Service manager](https://github.com/y2OS/yservice)
  
- [Wpa Supplicant helper](https://github.com/y2OS/ywifi)
  
- [Installation Script](https://github.com/y2OS/y2-install)
  

## Projects Under Development

- yservice 2.0
  
  - Rewriting yservice in Rust
    
  - Making yservice the default init system for y2OS
    

- y2config
  
  - Control center for y2OS
    
- ykernel
  
  - Kernel update system for y2OS
    
- ydisk
  
  - Disk formatting and ISO writing utility
    

## Additional

**System Requirements**

y2OS works exclusively on UEFI systems.

**Warning**

y2OS is an experimental distribution. Installing it on your daily primary hardware is not recommended. To test y2OS, you can use virtualization technologies or install it onto a USB drive.

## Copyright Statement

For copyright notices and licensing details of the open-source components included in y2OS, you can inspect the [LICENSE_INFO.md](https://github.com/y2OS/y2OS/blob/main/LICENSE_INFO.md) file.

For custom configurations, you can inspect the [src](https://github.com/y2OS/y2OS/tree/main/src) directory.

---

# Türkçe

# y2OS İşletim Sistemi

y2OS bağımsız bir Linux dağıtımıdır. Hiçbir dağıtımı taban almaz.

## Temel Özellikler

**Non-Systemd** Systemd olmadan daha yüksek performans alın, Unix felsefesine sadık kalın

**ypm paket yöneticisi** ana akım paket yöneticilerinin aksine /usr/bin gibi dizinleri doğrudan kullanmaz, /ypm altında statik paketler sunar.

**Sürücü desteği** Linux Firmware paketi iso içerisinde gelir.

**Wiki** Kurulum ve kullanım detaylarıyla ilgili bilgi almak için wiki sayfamızı ziyaret etmek için [tıklayın](https://github.com/y2OS/y2OS/wiki/Home-TR).

**Forum** Her türlü soru, hata bildirimi ve fikir için forumumuzu ziyaret etmek için [tıklayın](https://github.com/orgs/y2OS/discussions/categories).

**+100.000 paket** Nix Store ile kurulabilir

## Başlıca Bileşenler

y2OS bir çok açık kaynaklı yazılımı içerisinde barındırır. Başlıca bileşenlerimiz:

| Bileşen | Yazılım |
| --- | --- |
| Önyükleyici (Bootloader) | Limine *(Canlı ISO'da Grub)* |
| Init & Userland | BusyBox Init & BusyBox Tools |
| Servis Yöneticisi | yservice *(iso v1.1.0 ve sonrası)* |
| Paket Yönetimi | ypm & Nix Store |
| Pencere Yöneticisi | DWM (Dynamic Window Manager) |
| Varsayılan Shell | Zsh *(Canlı TTY'de BusyBox)* |
| Ses Mimarisi | PulseAudio & AlsaMixer |
| Ağ Yönetimi | wpa_supplicant  & ywifi |

## y2OS İçin Geliştirilen Projeler

- [Ana GitHub organizasyonumuz](https://github.com/y2OS)
  
- [ypm paket yöneticisi](https://github.com/y2OS/ypm)
  
- [Servis yöneticisi](https://github.com/y2OS/yservice)
  
- [Wpa Supplicant yardımcısı](https://github.com/y2OS/ywifi)
  
- [Kurulum Betiği](https://github.com/y2OS/y2-install)
  

## Geliştirilmekte Olan Projeler

- yservice 2.0
  
  - yservice'in Rust ile tekrar yazılması
    
  - yservice'in y2OS varsayılan init sistemi olması
    

- y2config
  
  - y2OS için ayar merkezi
    
- ykernel
  
  - y2OS kernel update sistemi
    
- ydisk
  
  - Disk formatlama ve İso yazdırma aracı
    

## Ek

**Sistem Gereksinimleri**

y2OS yalnızca Uefi sistemlerde çalışır.

**Uyarı**

y2OS deneysel bir dağıtımdır. Günlük bilgisayarınıza kurmanız tavsiye edilmez. y2OS'i denemek için sanallaştırma teknolojilerini ve Usb içine kurulum yapabilirsiniz

## Telif Hakları Beyanı

y2OS içerisinde barındırılan açık kaynaklı bileşenlerin telif hakları ve lisans bildirimleri için [LICENSE_INFO.md](https://github.com/y2OS/y2OS/blob/main/LICENSE_INFO.md) dosyasını inceleyebilirsiniz.

Özel ayarlar için [src](https://github.0/y2OS/y2OS/tree/main/src) bölümünü inceleyebilirsiniz.
