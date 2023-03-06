# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  networking.networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager = {
    awesome.enable = true;
    awesome.noArgb = true;
    bspwm.enable = true;
    i3.enable = true;
  };
  programs.sway.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.haris = {
    isNormalUser = true;
    description = "Haris";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$6$GtkNGFJbAkl7f4Ru$6jtnBePSeG21VyJJ89UK6nTrfkuW35syVwKvdbcJh5kdbpOj/cwBACb2pC9Q1TrTudcGWOyx62i21aAhgDLQi.";
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
      qtox
      # sxiv # Simple X Image Viewer
      nsxiv # successor to sxiv
      fontpreview
      gimp
      inkscape
      mpv
      vlc
      yt-dlp
      pipe-viewer # YouTube client with CLI and GUI
      fzf
      ytfzf
      minitube
      freetube
      # kdenlive (not found as such in repo, it's a bit of a mess)
      obs-studio
      handbrake
      vscode
      scribus
      mdp
      texstudio
      kbibtex
      nb # notetaking and knowledge base app
      qxmledit
      mupdf
      evince
      # okular (not found as such in repo, it's a bit of a mess)
      pdfarranger
      gnuradio
      sdrpp
      gpredict
      # sdrangel (outdated repo files)
      fldigi
      wsjtx
      # flightgear (outdated repo files, also not suitable for very low-spec computers)
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    exa
    sqlitebrowser
    pandoc
  ];
  programs = {
    fish.enable = true;
    neovim.enable = true;
    htop.enable = true;
    git.enable = true;
    tmux.enable = true;
    tmux.clock24 = true;
    tmux.keyMode = "vi";
    vim.defaultEditor = true;
    # xwayland.enable = true;
    zsh.enable = true;
    zsh.ohMyZsh.enable = true;
    zsh.syntaxHighlighting.enable = true;
  };

  # Custom modifications
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      groups = [ "wheel" ];
      noPass = false;
      keepEnv = true;
      persist = true;
    }
  ];
  hardware.bluetooth.enable = true;
  fonts.fonts = with pkgs; [
    corefonts # old Microsoft fonts
    helvetica-neue-lt-std # Helvetica derivate
    vistafonts # newer Microsoft fonts
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    open-sans
    roboto
    roboto-mono
    source-code-pro
  ];
  fonts.enableDefaultFonts = true;
#   fonts.fontconfig.defaultFonts = { # fontconfig is the font configuration API of X11
#     emoji = "";
#     monospace = "";
#     sansSerif = "";
#     serif = "";
#   };
  users.defaultUserShell = pkgs.fish;

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
