# AI Coding Tools Module
# AI-powered terminal coding agents
{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    codex       # OpenAI Codex CLI - terminal coding agent
    codex-acp   # ACP adapter for Zed integration
    gemini-cli  # Google Gemini CLI agent
  ];
}
