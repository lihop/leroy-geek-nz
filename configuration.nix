{ config, pkgs, ... }:
let
  lgnz = (import ./default.nix { });
in
{
  environment.systemPackages = with pkgs; [
    lgnz
    nmap
  ];

  networking.firewall.allowedTCPPorts = [ 3000 ];

  systemd.services.lgnz = {
    description = "leroy.geek.nz";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "${lgnz}";
      ExecStart = "${lgnz}/leroy-geek-nz";
      Restart = "always";
      User = "www";
    };
  };

  users.extraUsers = {
    www = { };
  };
}
