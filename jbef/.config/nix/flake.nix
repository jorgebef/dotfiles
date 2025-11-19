{
  description = "jbef nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
  }: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        # pkgs.bat
        # pkgs.bun
        # pkgs.fd
        # pkgs.fish
        # pkgs.fnm
        # pkgs.fzf
        pkgs.go
        pkgs.imagemagick
        pkgs.lazygit
        # pkgs.neovim
        pkgs.ollama
        pkgs.pnpm
        # pkgs.raycast
        # pkgs.starship
        # pkgs.ripgrep
        # pkgs.sesh
        pkgs.stow
        # pkgs.tmux
        # pkgs.tree-sitter
        pkgs.vim
        # pkgs.zoxide
      ];

      fonts.packages = with pkgs; [
        jetbrains-mono
      ];

      homebrew = {
        enable = true;
        taps = [
          "sst/tap"
          "nikitabobko/tap"
          "mediosz/tap"
          "mongodb/brew"
          "osx-cross/avr"
          "oven-sh/bun"
        ];
        brews = [
          "osx-cross/avr/avr-gcc"
          "bat"
          "ca-certificates"
          "oven-sh/bun/bun"
          "fd"
          "fish"
          "fzf"
          "fnm"
          "gcc"
          "mongodb/brew/mongodb-community@8.2"
          "neovim"
          "sst/tap/opencode"
          "qmk/qmk/qmk"
          "ripgrep"
          "sesh"
          "starship"
          "tmux"
          "tree-sitter"
          "wget"
          "woff2"
          "zoxide"
          "zellij"
        ];
        casks = [
          "1password"
          "1password-cli"
          "nikitabobko/tap/aerospace"
          "mediosz/tap/swipeaerospace"
          "brave-browser"
          "gcc-arm-embedded"
          "ghostty"
          "handbrake-app"
          "iina"
          "jordanbaird-ice"
          "libreoffice"
          "obsidian"
          "ollama-app"
          "qbittorrent"
          "raycast"
          "spotify"
          "utm"
          "vial"
          "yaak"
        ];
        onActivation = {
          cleanup = "uninstall";
          upgrade = true;
        };
      };

      system.primaryUser = "jbef";

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # This allows to install non-free software
      nixpkgs.config.allowUnfree = true;
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#jbef
    darwinConfigurations."jbef" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "jbef";
            # # Optional: Declarative tap management
            # taps = {
            #   "homebrew/homebrew-core" = homebrew-core;
            #   "homebrew/homebrew-cask" = homebrew-cask;
            # };
            # mutableTaps = true;
            # # Automatically migrate existing Homebrew installations
            # autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."jbef".pkgs;
  };
}
