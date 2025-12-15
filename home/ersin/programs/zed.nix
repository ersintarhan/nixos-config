# Zed Editor Configuration
{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zed-editor = {
    enable = true;
    # Add nixd to Zed's PATH for Nix language support
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      # === Theme and Appearance (catppuccin manages theme) ===
      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "JetBrains Mono";
      # === Behavior ===
      autosave = "on_focus_change";
      format_on_save = "on";
      base_keymap = "VSCode";

      # === Telemetry ===
      telemetry.diagnostics = false;
      telemetry.metrics = false;

      # === Language Server Protocol (LSP) Settings ===
      lsp = {
        # Configure nixd for Nix language support
        nixd = {
          # These settings are passed to nixd
          settings.nixd = {
            # Automatically download flake inputs when needed
            # This fixes the "flake inputs are not available" warning
            options.autoArchive = true;
            suppress = {
              ignored = [ "sema-extra-with" ];
            };
          };
        };
        # Configure nil for Nix language support
        nil = {
          # These settings are passed to nil
          settings.nil = {
            # Automatically download flake inputs when needed
            # This fixes the "flake inputs are not available" warning
            options.autoArchive = true;
            diagnostics = {
              ignored = [
                "unused_with"
                "unused_binding"
              ];
            };
          };
        };
      };
    };

    # === Extensions ===
    # List of extensions to automatically install from Zed's registry
    extensions = [
      "nix" # Official Nix language extension
      "dockerfile" # Official Dockerfile language extension
      "vue"
      "csharp"
      "zig"
      "sql"
      "terraform"
      "ini"
      "toml"
      "mcp-server-context7"
      "rust-snippets"
      "probe-rs"
      "catppuccin"
    ];
  };
}
