# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./xkeen-run.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://attic.xuyh0120.win/lantian" ];
    trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "tcp_bbr3" ];
    kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr3";
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems."/mnt/vault" = {
    device = "/dev/disk/by-uuid/F09803759803399C";
    fsType = "ntfs3";
  };

  networking = {
    hostName = "revolution-pc";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };
  gtk.iconCache.enable = true;

  services = {
    xserver.xkb = {
      layout = "ru";
      variant = "";
    };
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--performance" ];
    };
    displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="event*", ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';
    openssh.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
  };

  users.users."rv" = {
    isNormalUser = true;
    description = "rv";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
    # packages = with pkgs; [ ];
  };
  security = {
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = [ "rv" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nft";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    shellAliases = {
      sns = "sudo nixos-rebuild switch";
      lg = "lazygit";
      e = "nvim";
    };
    sessionVariables.QS_ICON_THEME = "hicolor";
    systemPackages = with pkgs; [
      adwaita-icon-theme
      ayugram-desktop
      btop
      bun
      codex
      cups-pk-helper
      fastfetch
      fd
      fetch
      ffmpeg
      foot
      fzf
      gamescope
      gcc
      git
      go
      gtk3
      gtk4
      gum
      helix
      htop
      jq
      just
      kdePackages.breeze
      kdePackages.qt6ct
      kitty
      nftables
      tcpdump
      knot-dns
      lazygit
      mpv
      nautilus
      nixfmt
      nodejs
      nvtopPackages.nvidia
      nwg-look
      opencode
      protonplus
      python3
      qbittorrent
      ripgrep
      rustup
      statix
      tree-sitter
      udiskie
      umu-launcher
      unzip
      vial
      wget
      wl-clip-persist
      wl-clipboard
      xwayland-satellite
    ];
  };

  fonts.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.overlays = [
    (final: prev: {
      xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: rec {
        version = "0.8.1";
        src = final.fetchFromGitHub {
          owner = "Supreeeme";
          repo = "xwayland-satellite";
          rev = "v${version}";
          hash = "sha256-BUE41HjLIGPjq3U8VXPjf8asH8GaMI7FYdgrIHKFMXA=";
        };
        cargoDeps = final.rustPlatform.importCargoLock {
          lockFile = "${src}/Cargo.lock";
        };
      });
    })
  ];

  programs = {
    niri.enable = true;
    dank-material-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    flyline.enable = true;
    starship.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    keyboard.qmk.enable = true;
  };

  # programs.mtr.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # system.copySystemConfiguration = true; # (/run/current-system/configuration.nix)
  system.stateVersion = "26.05";

}
