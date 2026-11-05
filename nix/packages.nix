# SPDX-FileCopyrightText: 2022-2025 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        nethsm-exporter = pkgs.callPackage ../pkgs/nethsm-exporter { };
        oci-publish = pkgs.callPackage ../pkgs/oci-publish { };
        pkcs11-proxy = pkgs.callPackage ../pkgs/pkcs11-proxy { };
        systemd-sbsign = pkgs.callPackage ../pkgs/systemd-sbsign { };
        nethsm-pkcs11 = pkgs.callPackage ../pkgs/nethsm-pkcs11 { };
        softhsm2 = pkgs.callPackage ../pkgs/softhsm2 { };
        zot = pkgs.callPackage ../pkgs/zot { };
      };
    };
}
