# SPDX-FileCopyrightText: 2022-2025 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
# Inventory schema:
# - module: path to the host configuration module.
# - system: nixpkgs host platform for mkNixOS and deploy-rs grouping.
# - machine: optional deploy/install metadata (ip, internal_ip, nebula_ip, publicKey).
# - kind: optional; set to "vm" for outliers that should not be auto-generated via mkNixOS.
{
  uae-seclab-lighthouse = {
    module = ./uae/seclab/lighthouse/configuration.nix;
    system = "x86_64-linux";
    machine = {
      ip = "172.164.242.94";
      internal_ip = "10.51.48.4";
      nebula_ip = "10.43.43.1";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYdOsd6swR+x0AHmcm4ixi+KP/jGax9h/v29C5X0h3b";
    };
  };
  uae-seclab-nethsm-gateway = {
    module = ./uae/seclab/nethsm-gateway/configuration.nix;
    system = "x86_64-linux";
    machine = {
      ip = "10.161.5.238";
      internal_ip = "10.161.5.238";
      nebula_ip = "10.43.43.13";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTaE7O/g8BQZjLYBXn1Jkxm4YtF8wpoX9dRAqsODzRM";
    };
  };

}

# Reserved Nebula IPs for externally managed hosts:
# nebula_ip = 10.42.42.36 | uae-azureci-dev (managed in the humanoid repository)
