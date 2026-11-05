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
    nebula
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

  networking.hostName = "seclab-nethsm-gateway";

  # this server has been installed with 26.11
  system.stateVersion = lib.mkForce "26.11";

  nebula.enable = lib.mkDefault true;
  
  services.nebula.networks.seclab.listen.port = lib.mkForce 0;
  services.nebula.networks.seclab.relays = [ "10.43.43.1" ];

}
