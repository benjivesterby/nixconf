# Docs

## NixOS

### When changing key options these commands are necessary in nixos

```
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```
## Flake CMD

`sudo nixos-rebuild switch --flake .#Gopher --impure`
