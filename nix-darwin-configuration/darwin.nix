{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.vim pkgs.vscodium pkgs.git pkgs.legendary-gl pkgs.fish pkgs.joplin-desktop pkgs.qrencode pkgs.element-desktop
      pkgs.spotify
    ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [];
    casks = [
      "firefox" "nextcloud" "veracrypt" "gimp" "signal" "libreoffice"
    ];
  };
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  
  # intel binaries
  # remember to manually run softwareupdate --install-rosetta --agree-to-license first
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # fingerprint sudo
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide =true ;
      show-recents = false;
      mru-spaces = false;
      tilesize = 50;
      magnification = true;
      largesize = 55;
      persistent-apps = [
        "/System/Applications/Launchpad.app/"
        "/Applications/Firefox.app"
        "/System/Applications/Utilities/Terminal.app"
        "${pkgs.vscodium}/Applications/VSCodium.app"
        "${pkgs.joplin-desktop}/Applications/Joplin.app"
        "/Applications/Signal.app"
        "${pkgs.element-desktop}/Applications/Element.app"
        "/System/Applications/Messages.app/"
        "/System/Applications/Facetime.app/"
      ];
    };
    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}
