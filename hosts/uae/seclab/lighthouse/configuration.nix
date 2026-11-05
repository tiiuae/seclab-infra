# SPDX-FileCopyrightText: 2022-2025 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  inputs,
  modulesPath,
  lib,
  self,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ../../azureci/azure-common.nix
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
  ]
  ++ (with self.nixosModules; [
    common
    nebula
    openssh
    user-fayad
    user-jrautiola
  ]);

  # this server has been initialized with 26.11 with nixos-anywhere
  system.stateVersion = lib.mkForce "26.11";

  sops.defaultSopsFile = ./secrets.yaml;

  networking.hostName = "seclab-lighthouse";

  nebula = {
    enable = true;
    isLighthouse = true;
  };
}
