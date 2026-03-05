# link

- [An unofficial NixOS & Flakes book for beginners](https://discourse.nixos.org/t/an-unofficial-nixos-flakes-book-for-beginners/29561)
  - [flakes 홈페이지](https://nixos-and-flakes.thiscute.world/)
  - [flakes 설명서](https://nixos-and-flakes.thiscute.world/introduction/)

<hr />

# nix-home

# 세팅하고 적용하기

```bash
sudo nixos-rebuild switch --show-trace
```

# home manager세팅
- https://wiki.nixos.org/wiki/Home_Manager

- https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
  - Youtube link
    - [How to Use NixOS Home Manager (2026 Edition) | NixOS Guide Part 2](https://youtu.be/bFmvnJVd5yQ?si=eXJDM3o6oVD9iM9G)

# default shell(fish)
- https://wiki.nixos.org/wiki/Fish

# 한글 설치(fcitx5) 이게 젤 좋다.
- https://wiki.nixos.org/wiki/Fcitx5

# OBS Studio세팅

- https://wiki.nixos.org/wiki/OBS_Studio

# `vim` & `neovim` setting

- [(250728) NixOS - Install VIM and Neovim Low Orbit Flux](https://youtu.be/wFP9CbaeMe0?si=S2BIWCDdGCeBN2OP)

- `nvim /etc/nixos/configuration.nix` setting

- `nixos-rebuild switch`
- `sudo nixos-rebuild switch --show-trace`

# Installing NVIDIA Drivers on a Laptop in NixOS Guides
- https://discourse.nixos.org/t/installing-nvidia-drivers-on-a-laptop-in-nixos/70951

- (Reddit) https://www.reddit.com/r/NixOS/comments/1f67jwl/how_to_install_nvidia_drivers/
  - https://github.com/Arroquw/nixos-config/blob/main/modules/nixos/nvidia/default.nix

