{
  config,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.dotfiles.selfhosted.ollama;
in {
  options.dotfiles.selfhosted.ollama = {
    enable = lib.mkEnableOption "ollama";
  };
  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      host = "0.0.0.0";
      port = 11434;
      openFirewall = true;
      package = pkgs-unstable.ollama-rocm;
      rocmOverrideGfx = "12.0.1";
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "32768";
      };
      loadModels = [
        "qwen3-coder:30b"
        "qwen3.5:9b"
        "gemma4:26b"
      ];
    };
  };
}
