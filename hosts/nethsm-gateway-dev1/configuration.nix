# SPDX-FileCopyrightText: 2022-2025 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  self,
  inputs,
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    ./disk-config.nix
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
  ]
  ++ (with self.nixosModules; [
    common
    openssh
    user-fayad
  ]);

  sops.defaultSopsFile = ./secrets.yaml;

  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "ahci"
      "nvme"
      "uas"
      "usbhid"
      "sd_mod"
    ];
  };

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "seclab-nethsm-gateway-dev1";

  # this server has been installed with 26.11
  system.stateVersion = lib.mkForce "26.11";

  # Network configuration
  # Assign server wide DHCP
  # Assign static IP for secondary interface assigned for nethsm operations
  networking.useDHCP = true;

}
