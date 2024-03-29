{
  description = "Primary Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    user = "benji";
    system = "x86_64-linux";
    pkgs = import <nixos-unstable> {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
    contrast-detect-secrets = pkgs.python3Packages.callPackage ./detect-secrets.nix { };
  in {

      nixosConfigurations = {
        Gopher = lib.nixosSystem {
          inherit system;
          modules = [ 
	    ./configuration.nix
            home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.${user} = {
	        imports = [ 
		  ./home.nix
		];
	      };
	    }
	  ];
        };
      };
  };
}
