{ config, pkgs, inputs, ... }:

{
  programs.librewolf.profiles.mathieu.bookmarks = {
    enable = true;
    force = true;
    settings = [
      {
        "name" = "Administratif";
        "bookmarks" = [
          {
            "name" = "Ameli";
            "url" = "https://assure.ameli.fr/";
          }
          {
            "name" = "April";
            "url" = "https://members.april-international.com/en-us/home/welcome";
          }
          {
            "name" = "Bouygues Telecom";
            "url" = "https://www.bouyguestelecom.fr/mon-compte";
          }
          {
            "name" = "Caisse d'Epargne";
            "url" = "https://www.caisse-epargne.fr/espace-client/";
          }
          {
            "name" = "Doctolib";
            "url" = "https://www.doctolib.fr/";
          }
          {
            "name" = "Free";
            "url" = "https://mobile.free.fr/";
          }
          {
            "name" = "Revolut";
            "url" = "https://app.revolut.com/";
          }
          {
            "name" = "Sncf-connect";
            "url" = "https://www.sncf-connect.com/";
          }
        ];
      }
      {
        "name" = "Canada";
        "bookmarks" = [
          {
            "name" = "Arrima";
            "url" = "https://arrima.immigration-quebec.gouv.qc.ca/aiguillage/?";
          }
          {
            "name" = "CléCG";
            "url" = "https://clegc-gckey.gc.ca/";
          }
          {
            "name" = "CléGC - Compte";
            "url" = "https://www.canada.ca/fr/immigration-refugies-citoyennete/services/demande/comptes-ircc.html";
          }
          {
            "name" = "MIFI";
            "url" = "https://www.form.services.micc.gouv.qc.ca/dossierClient/faces/pages/authentification.jspx?lang=fr&app=DCAE&indCreationCompte=undefined&indCodeAutorisation=undefined";
          }
          {
            "name" = "Procédure d'immigration";
            "url" = "https://www.ulaval.ca/international/immigration/programme-detudes-ou-dechange-de-plus-de-6-mois";
          }
          {
            "name" = "UQAC - inscription";
            "url" = "https://uqac.moveonca.com/locallogin/54e6035a9c70068265000000/fra";
          }
        ];
      }
      {
        "name" = "Docs";
        "bookmarks" = [
          {
            "name" = "Nixos";
            "bookmarks" = [
              {
                "name" = "Home Manager";
                "url" = "https://home-manager-options.extranix.com/";
              }
              {
                "name" = "Nixhub";
                "url" = "https://www.nixhub.io/";
              }
              {
                "name" = "Nixos";
                "url" = "https://search.nixos.org/";
              }
              {
                "name" = "Noogle";
                "url" = "https://noogle.dev/";
              }
            ];
          }
          {
            "name" = "Arch";
            "url" = "http://wiki.archlinux.org/";
          }
          {
            "name" = "Boost";
            "url" = "https://www.boost.org/doc/";
          }
          {
            "name" = "C++ reference";
            "url" = "https://en.cppreference.com/w/";
          }
          {
            "name" = "ClangFormat";
            "url" = "https://clang.llvm.org/docs/ClangFormatStyleOptions.html";
          }
          {
            "name" = "IA";
            "url" = "http://ema.cri-info.cm/wp-content/uploads/2019/07/2019BurkovTheHundred-pageMachineLearning.pdf";
          }
          {
            "name" = "Libdwarf";
          }
          {
            "name" = "Linux Documentation";
            "url" = "https://linux.die.net/";
          }
          {
            "name" = "Man";
            "url" = "https://man7.org/linux/man-pages/";
          }
          {
            "name" = "Moderncv";
          }
          {
            "name" = "NASM Cheatsheet";
            "url" = "https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html";
          }
          {
            "name" = "OPCode";
            "url" = "https://www.felixcloutier.com/x86/";
          }
          {
            "name" = "Pico-sdk";
            "url" = "https://www.raspberrypi.com/documentation/pico-sdk/";
          }
          {
            "name" = "Syscall Table";
            "url" = "https://syscalls.mebeim.net/?table=x86%2F64%2Fx64%2Flatest";
          }
        ];
      }
      {
        "name" = "Epitech";
        "bookmarks" = [
          {
            "name" = "My";
            "url" = "https://my.epitech.eu/";
            "tags" = [ "intra" ];
          }
          {
            "name" = "Eip";
            "url" = "https://eip.epitech.eu/";
          }
          {
            "name" = "Intra";
            "url" = "https://intra.epitech.eu/";
            "tags" = [ "oldintra" ];
          }
          {
            "name" = "EpitechPromo2027";
            "url" = "https://www.github.com/EpitechPromo2027";
          }
          {
            "name" = "Skills";
            "url" = "https://skills.epitest.eu/";
          }
        ];
      }
      {
        "name" = "Hoster";
        "bookmarks" = [
          {
            "name" = "Google";
            "bookmarks" = [
              {
                "name" = "Drive";
                "url" = "https://drive.google.com/";
              }
              {
                "name" = "Gemini";
                "url" = "https://gemini.google.com/";
              }
            ];
          }
          {
            "name" = "Cloudflare";
            "url" = "https://dash.cloudflare.com/";
          }
          {
            "name" = "Hostinger";
            "url" = "https://hpanel.hostinger.com/";
          }
          {
            "name" = "Oracle";
            "url" = "https://cloud.oracle.com/";
          }
        ];
      }
      {
        "name" = "Office365";
        "bookmarks" = [
          {
            "name" = "Microsoft Teams";
            "url" = "http://teams.cloud.microsoft/";
          }
          {
            "name" = "Outlook";
            "url" = "https://outlook.cloud.microsoft/mail/";
          }
        ];
      }
      {
        "name" = "Proton";
        "bookmarks" = [
          {
            "name" = "ProtonCalendar";
            "url" = "https://calendar.proton.me/u/0";
          }
          {
            "name" = "ProtonDrive";
            "url" = "https://drive.proton.me/u/0";
          }
          {
            "name" = "ProtonMail";
            "url" = "https://mail.proton.me/u/0/inbox";
          }
          {
            "name" = "ProtonPass";
            "url" = "https://pass.proton.me/u/0";
          }
          {
            "name" = "SimpleLogin";
            "url" = "https://app.simplelogin.io/dashboard/";
          }
        ];
      }
      {
        "name" = "Lucy-Robotics";
        "bookmarks" = [
          {
            "name" = "Dashboard";
            "url" = "http://dashboard.lucy-robotics.com/";
          }
          {
            "name" = "Docmost";
            "url" = "https://docs.lucy-robotics.com/home";
          }
          {
            "name" = "Github";
            "url" = "https://github.com/Sentience-Robotics/";
            "tags" = [ "lucy-robotics" ];
          }
          {
            "name" = "Headscale UI";
            "url" = "http://hs-ui.lucy-robotics.com/";
          }
          {
            "name" = "Linkedin";
            "url" = "https://www.linkedin.com/company/lucy-robotics/";
          }
        ];
      }
      {
        "name" = "Flaticon";
        "url" = "https://www.flaticon.com/";
      }
      {
        "name" = "OpenStreetMap";
        "url" = "https://www.openstreetmap.org/";
        "tags" = [ "osm" ];
      }
      {
        "name" = "QRcode";
        "url" = "https://fr.qr-code-generator.com/";
      }
      {
        "name" = "Translate Fr->En";
        "url" = "https://translate.google.com/?sl=fr&tl=en&text=%s&op=translate";
        "keyword" = "en";
      }
      {
        "name" = "Translate En->Fr";
        "url" = "https://translate.google.com/?sl=en&tl=fr&text=%s&op=translate";
        "keyword" = "fr";
      }
    ];
  };
}
