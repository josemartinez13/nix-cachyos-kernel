{
  description = "CachyOS Kernels";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    flake-parts.url = "github:hercules-ci/flake-parts";

    cachyos-kernel = {
      url = "github:CachyOS/linux-cachyos";
      flake = false;
    };
    cachyos-kernel-patches = {
      url = "github:CachyOS/kernel-patches";
      flake = false;
    };
  };
  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        lib,
        ...
      }:
      let
        loadPackages =
          pkgs:
          lib.removeAttrs
            (pkgs.callPackage ./kernel-cachyos {
              inherit inputs;
            })
            [
              "override"
              "overrideDerivation"
            ];
      in
      rec {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        perSystem =
          {
            pkgs,
            ...
          }:
          rec {
            # Legacy packages contain linux-cachyos-* and linuxPackages-cachyos-*
            legacyPackages = loadPackages pkgs;

            # Packages only contain linux-cachyos-* due to Flake schema requirements
            packages = lib.filterAttrs (_: lib.isDerivation) legacyPackages;
          };

        flake = {
          overlay = self.overlays.default;
          overlays.default = final: prev: {
            cachyosKernels = loadPackages prev;
          };

          nixosConfigurations = lib.genAttrs systems (
            system:
            inputs.nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                (
                  { pkgs, ... }:
                  {
                    nixpkgs.overlays = [ self.overlay ];
                    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

                    # Minimal config to make test configuration build
                    boot.loader.grub.devices = [ "/dev/vda" ];
                    fileSystems."/" = {
                      device = "tmpfs";
                      fsType = "tmpfs";
                    };
                    system.stateVersion = lib.trivial.release;
                  }
                )
              ];
            }
          );
        };
      }
    );
}
