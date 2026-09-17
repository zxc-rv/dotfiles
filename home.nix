{ pkgs, lib, ... }:
{
  home = {
    username = "rv";
    homeDirectory = "/home/rv";
    stateVersion = "26.05";
    file.".config/mpv".source = ./.config/mpv;
    packages = with pkgs; [
      (writeShellScriptBin "xkeen-run" (builtins.readFile ./scripts/xkeen-run))
      (writeShellScriptBin "cs" (builtins.readFile ./scripts/cs))
      (writeShellScriptBin "edit" (builtins.readFile ./scripts/edit))
      ayugram-desktop
      btop
      bun
      codex
      dysk
      fastfetch
      fd
      fetch
      ffmpeg
      foot
      fzf
      gamescope
      gcc
      go
      gpu-screen-recorder-gtk
      gum
      helix
      htop
      ipinfo
      jq
      just
      knot-dns
      lazygit
      localsend
      mpv
      nh
      nil
      nixfmt
      nodejs
      nvtopPackages.nvidia
      nwg-look
      protonplus
      python3
      qbittorrent
      ripgrep
      rustup
      statix
      tcpdump
      tree-sitter
      udiskie
      umu-launcher
      unzip
      vesktop
      vial
      wl-clip-persist
      wl-clipboard
      opencode-desktop
    ];
    activation.xkeenVesktopDesktop = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.local/share/applications"
      ${pkgs.gnused}/bin/sed "s|^Exec=vesktop \(.*\)|Exec=sh -c 'xkeen-run vesktop \1 > /dev/null 2>&1'|" \
        ${pkgs.vesktop}/share/applications/vesktop.desktop \
        > "$HOME/.local/share/applications/vesktop.desktop"
    '';
  };
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        sns = "sudo nixos-rebuild switch --impure --flake /home/rv/dotfiles#revolution-pc";
        lg = "lazygit";
        e = "nvim";
        ii = "ipinfo";
      };
      bashrcExtra = ''
        flyline editor --show-inline-history-metadata false
        flyline mouse --mode disabled
        flyline set-cursor --backend terminal
      '';
    };
    starship.enable = true;
    git = {
      enable = true;
      settings.user = {
        name = "zxc-rv";
        email = "the.revolution@icloud.com";
      };
    };
    kitty = {
      enable = true;
      settings = {
        auto_reload_config = "0.1";
        confirm_os_window_close = "0";
        dynamic_background_opacity = "yes";
        input_delay = "0";
        remember_window_size = "no";
        repaint_delay = "2";
        sync_to_monitor = "no";
        url_style = "curly";
        wayland_enable_ime = "no";
        window_padding_width = "20";
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
        background_opacity = "0.8";
        background_blur = "1";
        scrollback_lines = "10000";
        wheel_scroll_multiplier = "3.0";
        font_size = "11.5";
        font_family = "JetBrainsMono Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        cursor_blink_interval = "0";
        cursor_shape = "block";
        cursor_trail = "1";
        cursor_trail_decay = "0.01 0.4";
        mouse_hide_wait = "3.0";
        copy_on_select = "clipboard";
        paste_actions = "quote-urls-at-prompt";
        select_by_word_characters = ",│`|:\"' ()[]{}<>";
      };
      keybindings = {
        "ctrl+v" = "paste_from_clipboard";
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+shift+f" = "launch --type=overlay kitty +kitten icat";
        "shift+page_up" = "scroll_page_up";
        "shift+page_down" = "scroll_page_down";
        "shift+home" = "scroll_home";
        "shift+end" = "scroll_end";
        "ctrl+0" = "change_font_size all 0";
      };
      extraConfig = ''
        mouse_map middle release ungrabbed paste_from_selection
        include dank-tabs.conf
        include dank-theme.conf
      '';
    };
    vicinae.enable = true;
    imv.enable = true;
    # opencode.enable = true;
  };
}
