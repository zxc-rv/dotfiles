{
  description = "zxc-flake";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    helium-browser = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    flyline.url = "github:HalFrgrd/flyline";
  };
  outputs =
    {
      nixpkgs,
      helium-browser,
      dms,
      nix-cachyos-kernel,
      flyline,
      ...
    }:
    {
      nixosConfigurations.revolution-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          dms.nixosModules.dank-material-shell
          flyline.nixosModules.default
          ({ pkgs, ... }: {
            environment.systemPackages = [ pkgs.helium ];
            nixpkgs.overlays = [
              helium-browser.overlays.default
              nix-cachyos-kernel.overlays.pinned
            ];
          })
        ];
      };
    };
}
