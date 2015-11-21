{
  website = {
    deployment.targetEnv = "none";
    deployment.targetHost = "leroy.geek.nz"; 

    imports = [
      /etc/nixos/config/devices/vultr-768.nix
      /etc/nixos/config/roles/vultr-vps.nix
    ];
  };
}
