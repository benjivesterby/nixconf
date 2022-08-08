{
  description = "Primary Flake";

  inputs = {
    # All packages should follow latest nixpkgs/nur
    unstable.url = "github:nixos/nixpkgs/master";
    nur.url = "github:nix-community/NUR";
    # Nix-Darwin
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "unstable";
    };
    # HM-manager for dotfile/user management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager,... }@inputs:
  let
    user = "benji";
    pkgs = import nixpkgs {
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
    contrast-detect-secrets = pkgs.python3Packages.callPackage ../detect-secrets.nix { };
  in {

      darwinConfigurations."Centurion" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ 
            ./configuration.nix
            home-manager.darwinModule.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = {
                imports = [ 
                  ../home.nix
                ];
              };
            }
          ];
      };
  };
}
