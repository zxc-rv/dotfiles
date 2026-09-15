{
  description = "zxc-flake";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    flyline.url = "github:HalFrgrd/flyline";
    helium-browser = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      cachyos-kernel,
      flyline,
      helium-browser,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.revolution-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          flyline.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rv = import ./home.nix;
            };
          }
          helium-browser.nixosModules.default
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              helium-browser.overlays.default
              cachyos-kernel.overlays.pinned
            ];
            programs.helium = {
              enable = true;
              flags = [ "--enable-features=VaapiOnNvidiaGPUs" ];
              policies = {
                ExtensionInstallForcelist = [
                  "ajopnjidmegmdimjlfnijceegpefgped"
                  "ghmbeldphafepmbegfdlkpapadhbakde"
                  "mnjggcdmjocbbbhaepdhchncahnbgone"
                  "gkeojjjcdcopjkbelgbcpckplegclfeg"
                ];
              };
            };
          })
        ];
      };
    };
}
