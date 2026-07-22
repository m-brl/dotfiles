{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;

    history = {
      size = 9999;
      save = 9999;
      share = true;
    };

    plugins = [
    ];

    initContent = ''
      eval "$(direnv hook zsh)"
    '';
  };

  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    
    ripgrep.enable = true;
    bat.enable = true;
  };
}
