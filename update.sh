#!/usr/bin/env bash
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
sudo nixos-rebuild switch --flake .#Gopher --impure 
