{
  inputs,
  callPackage,
  lib,
  linux_latest,
  linux_testing,
  linux,
  ...
}:
let
  mkCachyKernel = callPackage ./mkCachyKernel.nix { inherit inputs; };
in
builtins.listToAttrs (
  builtins.map (v: lib.nameValuePair v.pname v) [
    (mkCachyKernel {
      pname = "linux-cachyos-latest";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-latest-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos";
      lto = true;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-lts";
      inherit (linux) version src;
      configVariant = "linux-cachyos-lts";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-lts-lto";
      inherit (linux) version src;
      configVariant = "linux-cachyos-lts";
      lto = true;
    })

    # Additional CachyOS provided variants
    (mkCachyKernel {
      pname = "linux-cachyos-bmq";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-bmq";
      lto = false;
      cpusched = "bmq";
    })
    (mkCachyKernel {
      pname = "linux-cachyos-bmq-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-bmq";
      lto = true;
      cpusched = "bmq";
    })
    (mkCachyKernel {
      pname = "linux-cachyos-bore";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-bore";
      lto = false;
      cpusched = "bore";
    })
    (mkCachyKernel {
      pname = "linux-cachyos-bore-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-bore";
      lto = true;
      cpusched = "bore";
    })
    (mkCachyKernel {
      pname = "linux-cachyos-deckify";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-deckify";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-deckify-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-deckify";
      lto = true;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-eevdf";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-eevdf";
      cpusched = "eevdf";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-eevdf-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-eevdf";
      cpusched = "eevdf";
      lto = true;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-hardened";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-hardened";
      hardened = true;
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-hardened-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-hardened";
      hardened = true;
      lto = true;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-rc";
      inherit (linux_testing) version src;
      configVariant = "linux-cachyos-rc";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-rc-lto";
      inherit (linux_testing) version src;
      configVariant = "linux-cachyos-rc";
      lto = true;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-rt-bore";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-rt-bore";
      rt = true;
      cpusched = "bore";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-rt-bore-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-rt-bore";
      rt = true;
      cpusched = "bore";
      lto = true;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-server";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-server";
      cpusched = "eevdf";
      hzTicks = "300";
      preemptType = "none";
      lto = false;
    })
    (mkCachyKernel {
      pname = "linux-cachyos-server-lto";
      inherit (linux_latest) version src;
      configVariant = "linux-cachyos-server";
      cpusched = "eevdf";
      hzTicks = "300";
      preemptType = "none";
      lto = true;
    })
  ]
)
