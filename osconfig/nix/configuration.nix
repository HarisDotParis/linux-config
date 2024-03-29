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
    defaultLocale = "en_GB.utf8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_IE.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.utf8";
      LC_IDENTIFICATION = "en_GB.utf8";
      LC_MEASUREMENT = "en_GB.utf8";
      LC_MONETARY = "en_IE.utf8";
      LC_NAME = "en_GB.utf8";
      LC_NUMERIC = "en_GB.utf8";
      LC_PAPER = "en_GB.utf8";
      LC_TELEPHONE = "de_DE.utf8";
      LC_TIME = "en_GB.utf8";
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
    i3lock.enable = true;
    i3lock.u2fSupport = true;
  };
  hardware.opengl.enable = true; # necessary for OpenGL support in X11 & for Wayland compositors
  qt.enable = true;

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
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.flatpak.enable = true;
  services.fwupd.enable = true;


  users.defaultUserShell = pkgs.zsh;
  users.allowNoPasswordLogin = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.haris = {
    isNormalUser = true;
    description = "Haris";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
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
      zoxide
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
      flightgear
      libsForQt5.discover
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs = {
    _1password-gui.enable = true;
    ausweisapp.enable = true;
    ausweisapp.openFirewall = true;
    chromium = {
      enable = true;
      defaultSearchProviderSuggestURL = "https://www.startpage.com/sp/search?query={searchTerms}";
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "ldpochfccmkkmhdbclfhpagapcfdljkj" # Decentraleyes
        "cofdbpoegempjloogbagkncekinflcnj" # DeepL Translate
      ];
      extraOpts = {
      # options: https://chromeenterprise.google/intl/en_us/policies/
        "AutofillAddressEnabled" = false;
        "AutofillCreditCardEnabled" = false;
        "AutoplayAllowed" = false;
        "BackgroundModeEnabled" = false;
        "BlockThirdPartyCookies" = true;
        "BrowserSignin" = 0;
        "BuiltInDnsClientEnabled" = false;
        "ClearBrowsingDataOnExitList" = [
          # "browsing_history",
          "download_history",
          "cookies_and_other_site_data",
          "cached_images_and_files",
          "password_signin",
          "autofill",
          # "site_settings",
          # "hosted_app_data",
        ];
        "CloudReportingEnabled" = false;
        "DefaultBrowserSettingEnabled" = false;
        "DefaultCookiesSetting" = 4;
        "DefaultGeolocationSetting" = 2;
        "DefaultInsecureContentSetting" = 3;
        "DefaultNotificationsSetting" = 3;
        "DomainReliabilityAllowed" = false;
        "ForcedLanguages" = [
          "en-IE"
          "en-GB"
        ];
        "GoogleSearchSidePanelEnabled" = false;
        "HttpsOnlyMode" = force_enabled;
        "NotificationsAllowedForUrls" = [
          "https://[*.]microsoft.com"
          "https://[*.]cloud.microsoft"
        ];
        "PasswordManagerEnabled" = false;
        "PaymentMethodQueryEnabled" = false;
        "RestoreOnStartup" = 1;
        "SearchSuggestEnabled" = false;
        "ShowHomeButton" = false;
        "SideSearchEnabled" = false;
        "SpellcheckEnabled" = false;
        "SyncDisabled" = true;
        "TranslateEnabled" = false;
        "UserAgentReduction" = 2;
      };
    };
    evolution.enable = true;
    evolution.plugins = [ pkgs.evolution-ews ];
    firefox.enable = true;
    firefox.languagePacks = ["en-GB"];
    firefox.policies = {
      "Cookies": {
        "AcceptThirdParty": "from-visited",
        "ExpireAtSessionEnd": true,
        "RejectTracker": true,
        "Locked": false,
        "Behavior": "reject-tracker",
        "BehaviorPrivateBrowsing": "reject-tracker",
      },
      "DisablePocket": true,
      "DisableTelemetry": true,
      "DisplayMenuBar": "default-on",
      "DNSOverHTTPS": {
        "Enabled": false,
      },
      "EnableTrackingProtection": {
        "Value": true,
        "Locked": false,
        "Cryptomining": true,
        "Fingerprinting": true,
        # "Exceptions": ["https://example.com"]
      },
      "ExtensionSettings": {
        "*": {
          "blocked_install_message": "Plugin installation not allowed by Nix config policy.",
          "installation_mode": "blocked",
          "allowed_types": ["extension", “dictionary”, “locale”]
        },
        "uBlock0@raymondhill.net": {
          "installation_mode": "force_installed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
        },
        "addon@darkreader.org": {
          "installation_mode": "normal_installed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi"
        },
        "smartproxy@salarcode.com": {
          "installation_mode": "normal_installed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/smartproxy/latest.xpi"
        },
        "passbolt@passbolt.com": {
          "installation_mode": "normal_installed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/passbolt/latest.xpi"
        },
        "{d634138d-c276-4fc8-924b-40a0ea21d284}": {
          "installation_mode": "normal_installed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi"
        },
        "jid1-BoFifL9Vbdl2zQ@jetpack": {
          "installation_mode": "normal_installed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi"
        },
        "{da35dad8-f912-4c74-8f64-c4e6e6d62610}": {
          "installation_mode": "allowed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/auto-refresh-page/latest.xpi"
        },
        "{0981817c-71b3-4853-a801-481c90af2e8e}": {
          "installation_mode": "allowed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/mozlz4-edit/latest.xpi"
        },
        "{446900e4-71c2-419f-a6a7-df9c091e268b}": {
          "installation_mode": "allowed",
          "install_url": "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
        },
      },
      "FirefoxHome": {
        "Search": false,
        "TopSites": false,
        "SponsoredTopSites": false,
        "Highlights": false,
        "Pocket": false,
        "SponsoredPocket": false,
        "Snippets": false,
        "Locked": false,
      },
      "Homepage": {
        "URL": "about:newtab",
        "Locked": false,
        "StartPage": "previous-session",
      },
      "NetworkPrediction": true,
      "NoDefaultBookmarks": true,
      "OfferToSaveLogins": false,
      "OverrideFirstRunPage": "",
      "OverridePostUpdatePage": "",
      "SearchSuggestEnabled": false,
      "ShowHomeButton": false,
    };
    git.enable = true;
    htop.enable = true;
    less.enable = true;
    neovim.enable = true;
    nm-applet.enable = true;
    slock.enable = true;
    ssh.startAgent = true;
    steam.enable = true;
    thefuck.enable = true;
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      historyLimit = 10000;
    };
    traceroute.enable = true;
    vim.defaultEditor = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      histSize = 10000;
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
          "zoxide"
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
