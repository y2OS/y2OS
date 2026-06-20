# y2OS — Independent & Minimalist Linux Distribution

y2OS is an independent Linux distribution built from scratch (LFS). It is not based on any existing mainstream distribution and is designed to give you complete control from the ground up.

## Core Information
* Unlike mainstream distributions, y2OS uses **BusyBox** instead of the GNU coreutils for its userland.
* To manage and download packages, you can use the official y2OS package manager **`ypm`** or the **Nix Store**.
* Privilege escalation is handled by **`doas`** rather than `sudo`.
* y2OS comes pre-installed with the **DWM** (Dynamic Window Manager).
* The default shell is **Zsh**; Bash is not included.
* The system comes with the **`vi`** text editor out of the box.

## System Requirements
y2OS is designed exclusively for **UEFI** systems. Legacy BIOS is not supported.

## Installation
1. Download the latest ISO file from the **Releases** section.
2. Boot the ISO and wait for the live system to start.
3. Type `y2-install` in the terminal to launch the TUI installer.
4. Follow the on-screen prompts to configure your system, then reboot.
5. After rebooting, log in with your username and password. DWM will start automatically.

## Networking
* Use the **`ywifi`** tool to connect to the internet. Simply type `ywifi` in the terminal and use the TUI menu to select your network.
* Use `ping` to test your connection.
* Use `wget` to download files from the internet.

## DWM Keybindings
* **Super + T** or **Super + W**: Open `st` (Simple Terminal)
* **Super + E**: Open Thunar Graphical File Manager
* **Super + P**: Open `dmenu` Application Launcher
* **Super + Q**: Kill active client (Close window)
* **Super + Right Arrow**: Focus next window
* **Super + Left Arrow**: Focus previous window
* **Super + Up Arrow**: Move window from stack to Master area
* **Super + Down Arrow**: Push Master window into the stack
* **Super + Enter**: Promote the selected window to Master
* **Super + Shift + Right Arrow**: Increase Master area width
* **Super + Shift + Left Arrow**: Decrease Master area width
* **Alt + Tab**: Toggle to the previously active workspace (Tag)
* **Super + [1 - 9]**: Switch to virtual workspace [1-9]
* **Super + Shift + [1 - 9]**: Move the active window to workspace [1-9]
* **Super + B**: Toggle DWM status bar visibility
* **Super + Shift + T**: Set layout to Tiled mode
* **Super + F**: Set layout to Floating mode
* **Super + M**: Set layout to Monocle (Fullscreen) mode
* **Super + Shift + Q**: Quit the graphical session and return to TTY

## Copyright & Licensing
The copyright and licensing declarations for the open-source software used in this project have been uploaded to GitHub (See `COMPLIANCE.md`).
