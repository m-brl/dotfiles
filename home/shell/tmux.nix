{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.tmux-fzf
      tmuxPlugins.pass
    ];


    extraConfig = ''
      set -g @pass-key 'm'
      set -g @pass-copy-to-clipboard on

      bind v split-window -h
      bind s split-window -v

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind x confirm kill-pane
      bind X confirm kill-window
    '';
  };
}
