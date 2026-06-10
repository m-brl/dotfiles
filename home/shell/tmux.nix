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
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text "#W"
        '';
      }

    ];


    extraConfig = ''
      set -g @pass-key 'm'
      set -g @pass-copy-to-clipboard on

      set-option -g automatic-rename off
      set-option -g allow-rename on

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
