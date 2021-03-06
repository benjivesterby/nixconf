{ config, pkgs, lib, ... }:

let
  # set channel channel to nixpkgs-unstable
 # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
 # pkgs = import <nixpkgs> {
 #   overlays = [
 #     # https://github.com/NixOS/nixpkgs/issues/168984
 #     (self: super: {
 #       golangci-lint = super.golangci-lint.override {
 #         buildGoModule = super.buildGoModule;
 #       };
 #     })
 #   ];
 # };
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

  home.packages = with pkgs; [

    libpcap
    libcap
    gcc

  ];

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
    package = pkgs.go_1_18;
    goPath = "${builtins.getEnv "HOME"}/gopath";
    goBin = "${builtins.getEnv "HOME"}/gobin";
  };
}
