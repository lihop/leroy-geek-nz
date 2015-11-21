{
  network.description = "personal network"; 
  network.enableRollback = true;

  website =
    { config, pkgs, ... }:
    let
      lgnzAddress = "192.168.100.12";
      lgnzPort = "3000";
    in
    {
      # Network configuration
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 ];
      };

      services.nginx = {
        enable = true;
        httpConfig = ''
            server {
                listen 80;
                location / {
                    proxy_pass http://${lgnzAddress}:${lgnzPort};
                }
            }
        '';
      };

      # Container configuration
      containers.lgnz = {
        autoStart = true;
        config = import ../configuration.nix;
        privateNetwork = true;
        hostAddress = "192.168.100.10";
        localAddress = "${lgnzAddress}";
      };
    };
}
