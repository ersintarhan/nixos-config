# AI Coding Tools Module
# AI-powered terminal coding agents
{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    codex # OpenAI Codex CLI - terminal coding agent
    codex-acp # ACP adapter for Zed integration
    gemini-cli # Google Gemini CLI agent
    amazon-q-cli # Amazon Q CLI - terminal coding agent
    crush # AI-powered terminal coding agent
  ];
}
