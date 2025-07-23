{ config, lib, pkgs, ... }:

{
  networking.hostName = "amg-laptop";

  # Mask /dev/tpmrm0 because it timeouts on amg-laptop 
  systemd.tpm2.enable = false;
}

