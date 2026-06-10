{ config, pkgs, inputs, ... }:

{
  accounts.email.accounts = {
    "Mathieu BOREL [mathieu@mborel.com]" = {
      primary = true;
      address = "mathieu@mborel.com";
      realName = "Mathieu BOREL";
      userName = "mathieu@mborel.com";

      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.enable = true;
        tls.useStartTls = true;
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.enable = true;
        tls.useStartTls = true;
      };
      thunderbird = {
        enable = true;
        profiles = [ "mathieu" ];
        settings = id: {
        };
      };
    };

    "Mathieu BOREL [mathieu.borel@epitech.eu]" = {
      primary = false;
      address = "mathieu.borel@epitech.eu";
      realName = "Mathieu BOREL";
      userName = "mathieu.borel@epitech.eu";

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
      thunderbird = {
        enable = true;
        profiles = [ "mathieu" ];
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
  };
}
