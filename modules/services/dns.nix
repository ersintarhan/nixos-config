# Split DNS - Consul domains to local, others to Cloudflare
{ config, ... }:

{
  services.dnsmasq = {
    enable = true;
    settings = {
      # Consul domains → local DNS servers
      server = [
        # Old Consul cluster (10.101.x.x)
        "/consul/10.101.1.11"
        "/node.consul/10.101.1.11"
        "/service.consul/10.101.1.11"
        "/consul/10.101.1.12"
        "/consul/10.101.1.13"

        # New Ark cluster - arkenom domain (10.201.x.x)
        "/arkenom/10.201.0.2#8600"
        "/arkenom/10.201.0.3#8600"
        "/arkenom/10.201.0.4#8600"

        # Everything else → Cloudflare
        "1.1.1.1"
        "1.0.0.1"
      ];
      # Don't read /etc/resolv.conf
      no-resolv = true;
      # Cache size
      cache-size = 1000;
      # Listen on localhost
      listen-address = "127.0.0.1";
    };
  };

  # Don't let NetworkManager manage DNS - we use system dnsmasq
  networking.networkmanager.dns = "none";

  # Point resolv.conf to local dnsmasq
  networking.nameservers = [ "127.0.0.1" ];
}
