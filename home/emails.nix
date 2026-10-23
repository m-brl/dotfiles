{ lib, config, pkgs, inputs, ... }:

let
  isync = pkgs.isync.override { withCyrusSaslXoauth2 = true; };

  secretData = builtins.fromJSON
    (builtins.readFile "${inputs.secrets}/email.json");

  protonCert = "${config.home.homeDirectory}/.config/protonmail/bridge-v3/cert.pem";

  mkAccount = 
    { name, label, imap, smtp, passwordCommand, secret, folders, gpg,
    primary ? false, oauth2 ? false }:
    lib.recursiveUpdate {
      inherit primary passwordCommand imap smtp;
      address = secret.address;
      realName = secret.realname;
      userName = secret.username;

      gpg = {
        key = gpg;
        signByDefault = true;
        encryptByDefault = false;
      };

      signature = {
        showSignature = "append";
        delimiter = "-- ";
        text = ''
          ${secret.realname}
          Étudiant en cinquième année à EPITECH
          ${secret.phone}
          ${secret.address}
        '';
      };

      mbsync = { enable = true; create = "both"; expunge = "both"; };
      msmtp = { enable = true; };
      neomutt = {
        enable = true;
        mailboxName = "${label}/Inbox";

        extraMailboxes = map (folder: {
          mailbox = folder;
          name = "${label}/${folder}";
        }) folders;

        extraConfig = ''
          set pgp_default_key = "${gpg}"
          set pgp_sign_as = "${gpg}"
        '';
      };
      notmuch = {
        enable = true;
        neomutt.virtualMailboxes = [
          { name = "${label}:Unread"; query = "tag:unread and path:${name}/**"; }
          { name = "${label}:Flagged"; query = "tag:flagged and path:${name}/**"; }
        ];
      };
  } (lib.optionalAttrs oauth2 {
    mbsync.extraConfig.account.AuthMechs = "XOAUTH2";
    msmtp.extraConfig.auth = "xoauth2";
  });
in
{
  xdg.configFile."oama/config.yaml".source = 
    (pkgs.formats.yaml { }).generate "oama-config.yaml" {
      encryption.tag = "KEYRING";
      services.microsoft = {
        client_id = "9e5f94bc-e8a4-4e73-b8be-63364c29d753";
        tenant = "epitech.eu";
      };
    };

  accounts.email.accounts = {
    proton = mkAccount {
      name = "proton"; label = "Proton"; primary = true;
      gpg = "DB0F8609BBCF47D7958CF67F4EE34607DB27AED6";
      secret = secretData.proton;
      imap = { host = "127.0.0.1"; port = 1143; tls.enable = true; tls.useStartTls = true; tls.certificatesFile = protonCert; };
      smtp = { host = "127.0.0.1"; port = 1025; tls.enable = true; tls.useStartTls = true; tls.certificatesFile = protonCert; };
      passwordCommand = "${lib.getExe pkgs.pass-wayland} show email/proton";
      folders = [ "All Mail" "Drafts" "Sent" "Archive" "Spam" "Trash" ];
    };

    epitech = mkAccount {
      name = "epitech"; label = "Epitech"; primary = false; oauth2 = true;
      gpg = "DAA7201AF8C7C3FDC5C819E5CAFB84174E30F795";
      secret = secretData.epitech;
      imap = { host = "outlook.office365.com"; port = 993; tls.enable = true; tls.useStartTls = false; };
      smtp = { host = "smtp.office365.com"; port = 587; tls.enable = true; tls.useStartTls = true; };
      passwordCommand = "${lib.getExe pkgs.oama} access ${secretData.epitech.address}";
      folders = [ "Drafts" "Sent Items" "Trash" "Archive" ];
    };
  };

  home.file.".mailcap".text = ''
    text/html; ${lib.getExe pkgs.w3m} -dump -T text/html %s; copiousoutput; nametemplate=%s.html
  '';

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
    package = isync;
    frequency = "*:0/1";
    postExec = "${lib.getExe pkgs.notmuch} new";
  };

  programs.mbsync = {
    enable = true;
    package = isync;
  };
}
