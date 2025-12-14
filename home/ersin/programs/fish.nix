# Fish Shell Configuration
{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    # On-demand PostgreSQL tools
    functions = {
      psql = ''
        nix shell nixpkgs#postgresql_18 --command psql $argv
      '';
      pg_dump = ''
        nix shell nixpkgs#postgresql_18 --command pg_dump $argv
      '';
      pg_restore = ''
        nix shell nixpkgs#postgresql_18 --command pg_restore $argv
      '';
      redis-cli = ''
        nix shell nixpkgs#redis --command redis-cli $argv
      '';
    };

    shellAbbrs = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#bosgame";
      cleanup = "sudo nix-collect-garbage -d";
      gs = "git status";
      gp = "git push";
      cat = "bat"; # bat as cat replacement
    };
    interactiveShellInit = ''
      set -g fish_greeting  # Disable greeting

      # macOS style 'open' command
      function open
        xdg-open $argv &>/dev/null &
        disown
      end

      # Load SSH keys into agent (once per session)
      if test -z "$SSH_KEYS_LOADED"
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
        ssh-add ~/.ssh/id_rsa 2>/dev/null
        set -gx SSH_KEYS_LOADED 1
      end

      # Monitor brightness control (ddcutil)
      function bright
        if test (count $argv) -eq 0
          ddcutil getvcp 10 --display 1 | grep -oP 'current value = \s*\K\d+'
          return
        end
        ddcutil setvcp 10 $argv[1] --display 1 &
        ddcutil setvcp 10 $argv[1] --display 2 &
        wait
        echo "Brightness set to $argv[1]%"
      end

      function bright+
        set current (ddcutil getvcp 10 --display 1 | grep -oP 'current value = \s*\K\d+')
        set new (math $current + 10)
        if test $new -gt 100; set new 100; end
        bright $new
      end

      function bright-
        set current (ddcutil getvcp 10 --display 1 | grep -oP 'current value = \s*\K\d+')
        set new (math $current - 10)
        if test $new -lt 0; set new 0; end
        bright $new
      end
    '';
  };
}
