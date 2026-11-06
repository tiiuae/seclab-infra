# SPDX-FileCopyrightText: 2022-2025 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  self,
  inputs,
  modulesPath,
  lib,
  machines,
  config,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ../nethsm.nix
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

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "seclab-nethsm-gateway";

  # this server has been installed with 26.11
  system.stateVersion = lib.mkForce "26.11";

  # Network configuration
  # Assign server wide DHCP
  # Assign static IP for secondary interface assigned for nethsm operations
  networking = {
    useDHCP = true;
    interfaces.enp57s0u1 = {
      ipv4.addresses = [
        {
          address = "192.168.70.3";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "10.161.5.1";
      interface = "eno1";
    };
    nameservers = [
      "10.161.10.11"
      "10.161.10.12"
    ];
  };

  nebula.enable = lib.mkDefault true;

  nethsm.host = lib.mkDefault "192.168.70.20";
  pkcs11.proxy.listenAddr = machines.uae-seclab-nethsm-gateway.nebula_ip;

  # Fix nebula handshake issues in UAE
  services.nebula.networks.seclab.listen.port = lib.mkForce 0;
  services.nebula.networks.seclab.relays = [ "10.43.43.1" ];

  # This server is only exposed to the internal network
  # fail2ban only causes issues here
  services.fail2ban.enable = lib.mkForce false;

  services.nebula.networks."seclab".firewall = {
    inbound = [
      # pkcs11-daemon
      {
        port = config.pkcs11.proxy.listenPort;
        proto = "tcp";
        host = "any";
      }
    ];
  };
}
