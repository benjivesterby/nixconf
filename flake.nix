{
  description = "Primary Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }:
  let
    user = "benji";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
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

      darwinConfigurations = {
        Centurion = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ 
            ./darwin-configuration.nix
            home-manager.darwinModule.home-manager {
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
