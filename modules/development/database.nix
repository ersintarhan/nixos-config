# Desktop Packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # === Database Toools ===
    # PostgreSQL pager
    pspg
    redisinsight # Redis GUI
    postgresql_18 # PostgreSQL server
    pgcli # PostgreSQL CLI
    redis # Redis server
    sqlcmd # SQL Server CLI

  ];
}
