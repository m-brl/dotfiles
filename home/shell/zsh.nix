{ lib, config, pkgs, ... }:

let
    openTicket = pkgs.writeShellScriptBin "ticket" ''
        if [ -z "$1" ]; then
            echo "Usage: ticket <number>"
            exit 1
        fi

        URL="https://projects.lucy-robotics.com/projects/lucy/work_packages/$1"
        ${pkgs.xdg-utils}/bin/xdg-open "$URL" > /dev/null 2>&1 &
    '';

    openMaps = pkgs.writeShellScriptBin "maps" ''
        if [ -z "$1" ]; then
            echo "Usage: ticket <number>"
            exit 1
        fi

        URL="https://maps.google.com/maps?q=$1"
        ${pkgs.xdg-utils}/bin/xdg-open "$URL" > /dev/null 2>&1 &
    '';
in
{
  home.packages = [
    openTicket openMaps
  ];

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
      [[ -f ~/.env.secrets ]] && source ~/.env.secrets
      eval "$(direnv hook zsh)"

      print "Welcome $(whoami)"
      print "You have \033[32m$(zellij list-sessions | wc -l)\033[0m zellij sessions running"
      nb_mail=$(notmuch count tag:unread)
      if [ "$nb_mail" -eq 0 ]; then
        print "You have \033[32m$nb_mail\033[0m unread emails"
      elif [ "$nb_mail" -lt 10 ]; then
        print "You have \033[33m$nb_mail\033[0m unread emails"
      else
        print "You have \033[31m$nb_mail\033[0m unread emails"
      fi
    '';
  };

  programs.bash.enable = true;

  programs = {
    zellij = {
      enable = true;
      exitShellOnExit = true;
      enableZshIntegration = true;
      settings = {
        show_startup_tips = false;
        host_notification_protocol = "off";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    
    ripgrep.enable = true;
    bat.enable = true;
  };
}
