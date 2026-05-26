{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      [[ ! -f ${./p10k.zsh.config} ]] || source ${./p10k.zsh.config}
      eval "$(direnv hook zsh)"
    '';
  };
}
