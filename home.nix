{ config, lib, ... }:

let
  # set channel channel to nixpkgs-unstable
 # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
 pkgs= import <nixpkgs> {
   config.allowUnfree = true;
 };

 unstable = import <nixos-unstable> {
   config.allowUnfree = true;
  # overlays = [
  #   # https://github.com/NixOS/nixpkgs/issues/168984
  #   (self: super: {
  #     golangci-lint = super.buildGoPackage.override {go = pkgs.go_1_18; }{
  #       #buildGoModule = super.buildGoModule;
  #       name="golangci-lint";
  #       goPackagePath = "github.com/golangci/golangci-lint";
  #       src = super.fetchFromGitHub {
  #         owner="golangci"; 
  #         repo="golangci-lint"; 
  #         rev="master"; 
  #         sha256 = "sha256-yiouzerUFkNkSwndiRXK9RMTE9hAQw7fCwJvy7U+P/s=";
  #       };
  #     };
  #   })
  # ];
 };
  contrast-detect-secrets = pkgs.python3Packages.callPackage ./detect-secrets.nix { };
 # https://github.com/nix-community/neovim-nightly-overlay
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "benji";
  home.homeDirectory = "/home/benji";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = [
    # Stable
    pkgs.tmux

    # Terminals
    pkgs.alacritty
    pkgs.kitty
    pkgs.dig
    pkgs.ripgrep
    pkgs.python3
    pkgs.python3.pkgs.pip
    pkgs.jq
    pkgs.nettools
    pkgs.gnupg
    pkgs.pinentry-curses
    pkgs.cryptsetup
    pkgs.tree
    pkgs.kazam
    pkgs.nmap
    pkgs.xclip
    pkgs.llvm
    pkgs.htop                               # System monitor
    pkgs.ffmpeg
    pkgs.mplayer                            # Video player
    pkgs.imagemagick                        # Image manip library
    pkgs.arandr                             # GUI frontend for xrandr monitor configuration
    pkgs.rustc                              # Rust programming language
    pkgs.bc                                 # Basic calculator
    pkgs.irssi                              # Irc client
    pkgs.sqlite                             # sqlite database
    pkgs.unzip                              # .zip file util
    pkgs.scrot                              # Screenshot capturing
    pkgs.bat # cat alternative
    pkgs.exa # ls alternative
    pkgs.glances # top alternative
    pkgs.hyperfine # benchmarking
    pkgs.lua5_3
    pkgs.direnv
    pkgs.modd
    pkgs.automake
    pkgs.autoconf
    pkgs.libwebp
    pkgs.niv

    # Editors
    pkgs.goreleaser

    # Docker
    pkgs.docker
    pkgs.docker-compose
    pkgs.containerd

    # Libs
    pkgs.libcap
    pkgs.libpcap

    pkgs.# Packet Capture
    pkgs.wireshark
    pkgs.tcpdump

    # Linting
    pkgs.shellcheck
    pkgs.pre-commit
    pkgs.golangci-lint

    # Other
    pkgs.terraform
    pkgs.graphviz
    pkgs.wireguard-tools
    pkgs.signal-desktop
    pkgs.signal-cli
    pkgs.hugo
    pkgs.keybase
    pkgs.steam                              # Games
    pkgs.nodejs-16_x

    unstable.go_1_19
    contrast-detect-secrets

    pkgs.keybase
    pkgs.libpcap
    pkgs.libcap
    pkgs.gcc
    pkgs.postman
    pkgs.golangci-lint
    pkgs.drawio
    pkgs.openssl

    # libpcap requirements
    pkgs.flex
    pkgs.bison
    pkgs.discord
    pkgs.burpsuite
    pkgs.google-chrome
    pkgs.vscode
    pkgs.gimp
    pkgs.inkscape
    pkgs.atuin

    pkgs.bitwarden
    pkgs.bitwarden-cli
    unstable.zoom-us
    pkgs.insomnia
    pkgs.vlc

    pkgs.libdivecomputer
    pkgs.subsurface
    pkgs.socat

    pkgs.usbutils
    pkgs.ansible
    pkgs.screen
    #pkgs.inetutils

    # autotools
    pkgs.automake
    pkgs.autoconf
    pkgs.autogen
    pkgs.rustc
    pkgs.cargo
  ];
  
  gtk.iconTheme = pkgs.gnome.gnome-themes-extra;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = import ./nvim-conf.nix { inherit pkgs; };
  programs.starship = import ./starship-conf.nix { inherit pkgs lib; };
  programs.tmux = import ./tmux-conf.nix { inherit pkgs; };
  programs.zsh = import ./zsh-conf.nix { inherit pkgs; };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableFishIntegration = false;

    defaultCommand = "fd";
    fileWidgetCommand = "fd --hidden --exclude '.git'";
    changeDirWidgetCommand = "fd --type d --hidden --exclude '.git' --follow";
  };

  programs.go = {
    enable = true;
    package = unstable.go_1_19;
    goPath = "${builtins.getEnv "HOME"}/gopath";
    goBin = "${builtins.getEnv "HOME"}/gobin";
  };
}
