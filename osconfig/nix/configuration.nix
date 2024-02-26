# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
    hostName = "laptop"; # Define your hostname.
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
    wireless.iwd.enable = true;
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      insertNameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_IE.utf8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_IE.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_IE.utf8";
      LC_IDENTIFICATION = "en_IE.utf8";
      LC_MEASUREMENT = "en_IE.utf8";
      LC_MONETARY = "en_IE.utf8";
      LC_NAME = "en_IE.utf8";
      LC_NUMERIC = "en_IE.utf8";
      LC_PAPER = "en_IE.utf8";
      LC_TELEPHONE = "en_IE.utf8";
      LC_TIME = "en_IE.utf8";
    };
  };

  # Enable the X11 and WMs/DEs.
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasmawayland";
    windowManager = {
      awesome.enable = true;
      awesome.noArgb = true;
      bspwm.enable = true;
      i3.enable = true;
    };
  };
  programs = {
    xwayland.enable = true;
    sway.enable = true;
    hyprland.enable = true;
  };
  hardware.opengl.enable = true; # necessary for OpenGL support in X11 & for Wayland compositors

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
    # extraLayouts.haris.keycodesFile = 
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.haris = {
    isNormalUser = true;
    description = "Haris";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
      libreoffice
      obsidian
      thunderbird
      browsh # modern text-based browser running on headless Firefox
      w3m # text-based browser
      filezilla
      element-desktop
      # qtox
      nsxiv # successor to sxiv
      gimp
      inkscape
      vlc
      yt-dlp
      pipe-viewer # YouTube client with CLI and GUI
      fzf
      ytfzf
      minitube
      freetube
      libsForQt5.kdenlive
      obs-studio
      handbrake
      scribus
      mdp
      texstudio
      kbibtex
      nb # notetaking and knowledge base app
      qxmledit
      mupdf
      libsForQt5.okular
      pdfarranger
      gnuradio
      sdrpp
      gpredict
      sdrangel
      fldigi
      wsjtx
      vscode.fhs
      viu
      # flightgear (outdated repo files, also not suitable for very low-spec computers)
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs = {
    neovim.enable = true;
    htop.enable = true;
    git.enable = true;
    tmux.enable = true;
    tmux.clock24 = true;
    tmux.keyMode = "vi";
    vim.defaultEditor = true;
    # xwayland.enable = true;
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "lukerandall";
        extraConfig = "
          HYPHEN_INSENSITIVE="true"
          zstyle ':omz:update' mode auto
          zstyle ':omz:update' frequency 3
        "
        plugins = [
          "aliases"
          "ansible"
          "autopep8"
          "colored-man-pages"
          "colorize"
          "command-not-found"
          "extract"
          "gcloud"
          "git"
          "github"
          "gh"
          "history"
          "rust"
          "systemd"
          "terraform"
        ];
      };
    };
  };
  environment = {
    pathsToLink = [ "/share/zsh" ]; # necessary for zsh completion for system packages
    sessionVariables.NIXOS_OZONE_WL = "1"; # enable Wayland support for Electron- and Chromium-based apps
    systemPackages = with pkgs; [
      wget
      yakuake
      hugo
      deja-dup
      ark
      vifm
      colordiff
      kdiff3
      krename
      fd
      eza
      sqlitebrowser
      pandoc
      bat
      ripgrep
      tidy-viewer
      ansible
      terraform
    ];
  };

  # Custom modifications
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };
  hardware.bluetooth.enable = true;
  fonts = {
    enableDefaultFonts = true;
#     fontconfig.defaultFonts = { # fontconfig is the font configuration API of X11
#       emoji = "";
#       monospace = "";
#       sansSerif = "";
#       serif = "";
#     };
    packages = with pkgs; [
      corefonts # old Microsoft fonts
      vistafonts # newer Microsoft fonts
      helvetica-neue-lt-std # Helvetica derivate
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      liberation_ttf
      liberation-sans-narrow
      fira
      fira-code
      fira-code-symbols
      open-sans
      roboto
      roboto-mono
      roboto-serif
      roboto-slab
      source-code-pro
      source-sans
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
# Removed as it didn't work: clion & other Jetbrains products, JetBrainsMono, mousepad, linux-libertine, ubuntu-font-family
