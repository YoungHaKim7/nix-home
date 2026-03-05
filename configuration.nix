{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # -----------------------------
  # Home Manager
  # -----------------------------
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.gy = import ./home.nix;

  # -----------------------------
  # Bootloader
  # -----------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # -----------------------------
  # Networking
  # -----------------------------
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # -----------------------------
  # Time / Locale
  # -----------------------------
  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";
  #i18n.extraLocaleSettings = {
    #LC_ADDRESS = "ko_KR.UTF-8";
    #LC_IDENTIFICATION = "ko_KR.UTF-8";
    #LC_MEASUREMENT = "ko_KR.UTF-8";
    #LC_MONETARY = "ko_KR.UTF-8";
    #LC_NAME = "ko_KR.UTF-8";
    #LC_NUMERIC = "ko_KR.UTF-8";
    #LC_PAPER = "ko_KR.UTF-8";
    #LC_TELEPHONE = "ko_KR.UTF-8";
    #LC_TIME = "ko_KR.UTF-8";
  #};
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ko_KR.UTF-8/UTF-8" ];

  # -----------------------------
  # Input Method (fcitx5 for Hangul)
  # -----------------------------
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-hangul
        fcitx5-gtk
	    fcitx5-nord
      ];
      waylandFrontend = true;
    };
  };

  # -----------------------------
  # GNOME (Wayland)
  # -----------------------------
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # -----------------------------
  # Printing
  # -----------------------------
  services.printing.enable = true;

  # -----------------------------
  # Audio (PipeWire)
  # -----------------------------
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # -----------------------------
  # User
  # -----------------------------
  users.users.gy = {
    isNormalUser = true;
    description = "gy";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # -----------------------------
  # Allow Unfree (NVIDIA)
  # -----------------------------
  nixpkgs.config.allowUnfree = true;


  # ---------
  # default shell
  # ---------
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # -----------
  # Set the default editor to vim
  # -----------
  environment.variables.EDITOR = "vim";

  # -----------------------------
  # Fonts
  # -----------------------------
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
    nanum
    noto-fonts-cjk-sans
  ];

  # -----------------------------
  # Programs
  # -----------------------------
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    alacritty
    rustc
    cargo
    gcc
    clang-tools
    gnumake
    llvmPackages_latest.llvm
    llvmPackages_latest.clang
    llvmPackages_latest.lld
    wget
    git
    curl
  ];

  ######
  # dynamic libraries 
  ######
  # https://nix.dev/permalink/stub-ld
  #
  #programs.nix-ld.enable = true;
  #programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  #];


  # -----------------------------
  # Graphics
  # -----------------------------
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # -----------------------------
  # NVIDIA PRIME Offload
  # -----------------------------
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  # -----------------------------
  # System Version
  # -----------------------------
  system.stateVersion = "25.11";
}
