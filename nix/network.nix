{ email, domain, enableSSL ? true, ...}:
{
  network.description = "personal network";
  network.enableRollback = true;

  website =
    { config, pkgs, ... }:
    let
      lgnzAddress = "192.168.100.12";
      lgnzPort = "3000";
      certRenew = pkgs.writeScriptBin "renew" ''
        #!/bin/sh

        mkdir -p /etc/nginx/ssl/${domain}
        cd /etc/nginx/ssl/${domain}
        chmod -R 600 /etc/nginx/ssl/${domain}/*

        ${pkgs.simp_le}/bin/simp_le \
          -d ${domain}:/tmp/letsencrypt \
          --email ${email} \
          -f key.pem \
          -f cert.pem \
          -f fullchain.pem \
          && systemctl restart nginx.service

        chmod -R 400 /etc/nginx/ssl/${domain}/*
      '';
    in
    {
      environment.systemPackages = with pkgs; [
        simp_le
      ];

      # Network configuration
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 ];
      };

      services.nginx = {
        enable = true;
        httpConfig = ''
          server {
            server_name ${domain};
            listen 80;
        '' + (if enableSSL then ''
            return 301 https://$host$request_uri;
          }
          server {
            listen 443 ssl;

            ssl_stapling on;
            ssl_stapling_verify on;
            ssl_certificate /etc/nginx/ssl/${domain}/cert.pem;
            ssl_certificate_key /etc/nginx/ssl/${domain}/key.pem;
            ssl_trusted_certificate /etc/nginx/ssl/${domain}/fullchain.pem;
        '' else "") + ''
            location / {
                proxy_pass http://${lgnzAddress}:${lgnzPort};
            }
          }
        '';
      };

      services.cron = {
        enable = enableSSL;
        systemCronJobs =
          # Run a cron job to automatically renew
          # the Let's Encrypt SSL certificate
          [ "00 1 * * * echo ${certRenew}/bin/renew || true" ];
      };

      systemd.services.letsEncryptServer = {
        enable = enableSSL;
        description = "simple python server for Let's Encrypt verification";
        wantedBy = [ "getSSLCert.service" ];
        bindsTo = [ "getSSLCert.service" ];
        conflicts = [ "nginx.service" ];
        after = [ "networking.service" ];
        serviceConfig = {
          Type = "oneshot";
          WorkingDirectory = "/tmp/letsencrypt";
          ExecStart = ''
            ${pkgs.python3}/bin/python3 -m http.server 80
          '';
          User = "root";
        };
      };

      systemd.services.getSSLCert = {
        enable = enableSSL;
        description = "certificate renewal script";
        before = [ "nginx.service" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = ''
            ${certRenew}/bin/renew
          '';
          User = "root";
        };
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
