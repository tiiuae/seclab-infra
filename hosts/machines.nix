# SPDX-FileCopyrightText: 2022-2025 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
# Inventory schema:
# - module: path to the host configuration module.
# - system: nixpkgs host platform for mkNixOS and deploy-rs grouping.
# - machine: optional deploy/install metadata (ip, internal_ip, nebula_ip, publicKey).
# - kind: optional; set to "vm" for outliers that should not be auto-generated via mkNixOS.
{
  seclab-lighthouse = {
    module = ./lighthouse/configuration.nix;
    system = "x86_64-linux";
    machine = {
      ip = "172.164.242.94";
      internal_ip = "10.51.48.4";
      nebula_ip = "10.43.43.1";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYdOsd6swR+x0AHmcm4ixi+KP/jGax9h/v29C5X0h3b";
      environment = "azure";
    };
  };
  seclab-nethsm-gateway = {
    module = ./nethsm-gateway/configuration.nix;
    system = "x86_64-linux";
    machine = {
      ip = "10.161.5.238";
      internal_ip = "10.161.5.238";
      nebula_ip = "10.43.43.16";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTaE7O/g8BQZjLYBXn1Jkxm4YtF8wpoX9dRAqsODzRM";
      environment = "masdar";
    };
  };
  seclab-builder1 = {
    module = ./builder1/configuration.nix;
    system = "x86_64-linux";
    machine = {
      ip = "172.20.16.36";
      nebula_ip = "10.43.43.11";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEM7JQd03SZz7q27EsVt4oVIXfuu1d4LWuTjaA17yp3r";
      environment = "masdar,lab";
    };
  };
}

# Reserved Nebula IPs for externally managed hosts:
# nebula_ip = 10.43.43.12 | ismael-tii-kms-crc (provisioned for Ismael Kane at crc)
# nebula_ip = 10.43.43.14 | robotci (managed in ghaf-robots-infra)
# nebula_ip = 10.43.43.15 | carbon (managed in jrautiola's nix-infra)
# nebula_ip = 10.43.43.17 | robotlab (managed in ghaf-robots-infra)
# nebula_ip = 10.43.43.18 | kiran
# nebula_ip = 10.43.43.19 | sfoci (managed in ghaf-sfo-infra)
