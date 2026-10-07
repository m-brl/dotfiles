{ lib, config, pkgs, inputs, ... }:

let
  secretPath = "/home/mathieu/.secrets/emails/secret.json";
  secretData =
    if builtins.pathExists secretPath
    then builtins.fromJSON (builtins.readFile secretPath)
    else throw "Secret file not found at ${secretPath}";
in
{
  accounts.email.accounts = {
    "proton" = {
      primary = true;
      address = secretData.proton.address;
      realName = secretData.proton.realname;
      userName = secretData.proton.username;

      signature = {
        showSignature = "append";
        delimiter = "-- ";
        text = ''
          ${secretData.proton.realname}
          Étudiant en cinquième année à EPITECH
          ${secretData.proton.phone}
          ${secretData.proton.address}
        '';
      };

      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.enable = true;
        tls.useStartTls = true;
        tls.certificatesFile = "${config.home.homeDirectory}/.config/protonmail/bridge-v3/cert.pem";
      };

      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.enable = true;
        tls.useStartTls = true;
        tls.certificatesFile = "${config.home.homeDirectory}/.config/protonmail/bridge-v3/cert.pem";
      };

      passwordCommand = "${lib.getExe pkgs.pass} show email/proton";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };

      msmtp = {
        enable = true;
      };

      imapnotify = {
        enable = true;
        boxes = [ "Inbox" ];
        onNotify = "${lib.getExe pkgs.isync} proton";
        onNotifyPost = "${lib.getExe pkgs.notmuch} new";
      };

      neomutt = {
        enable = true;
        mailboxName = "Proton/Inbox";
        extraMailboxes = [
          { mailbox = "All Mail"; name = "Proton/All Mail"; }
          { mailbox = "Drafts"; name = "Proton/Drafts"; }
          { mailbox = "Sent"; name = "Proton/Sent"; }
          { mailbox = "Archive"; name = "Proton/Archive"; }
          { mailbox = "Spam"; name = "Proton/Spam"; }
          { mailbox = "Trash"; name = "Proton/Trash"; }
        ];
      };

      notmuch = {
        enable = true;
        neomutt.virtualMailboxes = [
          { name = "Proton/Inbox"; query = "path:proton/Inbox/**"; }
          { name = "Proton/Unread"; query = "tag:unread and path:proton/**"; }
          { name = "Proton/Flagged"; query = "tag:flagged and path:proton/**"; }
        ];
      };

    };

    "epitech" = {
      primary = false;
      address = secretData.epitech.address;
      realName = secretData.epitech.realname;
      userName = secretData.epitech.username;

      signature = {
        showSignature = "append";
        delimiter = "-- ";
        text = ''
          ${secretData.epitech.realname}
          Étudiant en cinquième année à EPITECH
          ${secretData.epitech.phone}
          ${secretData.epitech.address}
        '';
      };

      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
        tls.useStartTls = false;
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.enable = true;
        tls.useStartTls = true;
      };

      passwordCommand = "${lib.getExe pkgs.oama} access ${secretData.epitech.address}";

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        extraConfig.account = {
          AuthMechs = "XOAUTH2";
        };
      };

      msmtp = {
        enable = true;
        extraConfig = {
          auth = "xoauth2";
        };
      };

      imapnotify = {
        enable = true;
        boxes = [ "Inbox" ];
        onNotify = "${lib.getExe pkgs.isync} epitech";
        onNotifyPost = "${lib.getExe pkgs.notmuch} new";
      };

      neomutt = {
        enable = true;
        mailboxName = "Epitech/Inbox";
        extraMailboxes = [
          { mailbox = "Drafts"; name = "Epitech/Drafts"; }
          { mailbox = "Sent Items"; name = "Epitech/Sent Items"; }
          { mailbox = "Trash"; name = "Epitech/Trash"; }
          { mailbox = "Archive"; name = "Epitech/Archive"; }
        ];
      };

      notmuch = {
        enable = true;
        neomutt.virtualMailboxes = [
          { name = "Epitech/Inbox"; query = "path:epitech/Inbox/**"; }
          { name = "Epitech/Unread"; query = "tag:unread and path:epitech/**"; }
          { name = "Epitech/Flagged"; query = "tag:flagged and path:epitech/**"; }
        ];
      };
    };
  };

  home.packages = [ pkgs.w3m ];

  home.file.".mailcap".text = ''
    text/html; w3m -dump -T text/html %s; copiousoutput; nametemplate=%s.html
  '';

  programs.mbsync = {
    enable = true;
    package = pkgs.isync.override { withCyrusSaslXoauth2 = true; };
  };
  programs.msmtp.enable = true;
  programs.neomutt = {
    enable = true;
    vimKeys = true;
    checkStatsInterval = 60;
    sidebar = {
      enable = true;
      width = 30;
    };
    extraConfig = ''
        auto_view text/html

        bind index,pager \Cp sidebar-prev
        bind index,pager \Cn sidebar-next
        bind index,pager \Co sidebar-open
    '';
  };
  programs.notmuch = {
    enable = true;
    new.tags = [ "unread" "new" ];
    hooks.postNew = ''
      ${lib.getExe pkgs.notmuch} search --format=json --sort=newest-first \
          'tag:new and ( path:proton/Inbox/** or path:epitech/Inbox/** )' \
        | ${lib.getExe pkgs.jq} -r '.[] | "\(.authors)\t\(.subject)"' \
        | while IFS=$'\t' read -r from subject; do
            ${lib.getExe pkgs.libnotify} -a "Mail" -i mail-unread -- "Nouveau mail de $from" "$subject"
          done
      ${lib.getExe pkgs.notmuch} tag -new -- tag:new
    '';
  };

  services.mbsync = {
    enable = true;
    package = pkgs.isync.override { withCyrusSaslXoauth2 = true; };
    frequency = "*:0/5";
    postExec = "${lib.getExe pkgs.notmuch} new";
  };

  services.imapnotify = {
    enable = true;
  };
}
