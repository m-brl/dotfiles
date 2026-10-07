{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nix-openclaw.homeManagerModules.openclaw
  ];

  programs.openclaw = {
    enable = true;

    # discord disabled: nix-openclaw plugin fails OpenClaw's trust gate on
    # openKeyedStore (config-origin plugins have no install provenance).
    # Tracked upstream: https://github.com/openclaw/nix-openclaw/issues/158
    runtimePlugins = [ "firecrawl" "whatsapp" "memory-lancedb" ];

    environment = {
      FIRECRAWL_API_KEY = "/home/mathieu/.secrets/openclaw/firecrawl-api-key";
      OPENCLAW_GATEWAY_TOKEN = "/home/mathieu/.secrets/openclaw/gateway-token";
      TELEGRAM_GATEWAY_TOKEN = "/home/mathieu/.secrets/openclaw/telegram-token";
      DISCORD_TOKEN = "/home/mathieu/.secrets/openclaw/discord-token";
    };

    config = {
      plugins.allow = [];

      gateway = {
        mode = "local";
        auth = {
          mode = "token";
          token = { source = "env"; provider = "default"; id = "OPENCLAW_GATEWAY_TOKEN"; };
        };
      };

      models.providers.ollama = {
        baseUrl = "http://127.0.0.1:11434";
        api = "ollama";
        models = [
          {
            id = "qwen3:8b";
            name = "Qwen3 8B";
            contextWindow = 16384;
            contextTokens = 16384;
            params.num_ctx = 16384;
            params.keep_alive = "10m";
          }
          {
            id = "qwen2.5-coder:14b";
            name = "Qwen2.5 Coder 14B";
            contextWindow = 32768;
            contextTokens = 32768;
            params.num_ctx = 32768;
            params.keep_alive = "10m";
          }
        ];
      };

      channels = {
        whatsapp = {
          enabled = false;
          dmPolicy = "allowlist";
          allowFrom = [];
        };
        telegram = {
          enabled = true;
          dmPolicy = "allowlist";
          allowFrom = [ "6558618214" ];
          tokenFile = "/home/mathieu/.secrets/openclaw/telegram-token";
        };
        discord = {
          enabled = false;
          token = {
            source = "env";
            provider = "default";
            id = "DISCORD_TOKEN";
          };
        };
      };

      agents.defaults.model = "ollama/qwen2.5-coder:14b";
      agents.defaults.heartbeat.every = "0m";
      agents.defaults.models."anthropic/claude-haiku-4-5".agentRuntime.id = "claude-cli";
      agents.defaults.models."anthropic/claude-sonnet-5".agentRuntime.id = "claude-cli";
      agents.defaults.models."anthropic/claude-opus-5".agentRuntime.id = "claude-cli";
    };
  };

  systemd.user.services.openclaw-gateway.Install.WantedBy = [ "default.target" ];
}
