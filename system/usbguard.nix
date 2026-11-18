{ pkgs, ... }:

let
  rules = ''
    allow id 1d6b:0002 serial "0000:00:14.0" name "xHCI Host Controller" hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
    allow id 1d6b:0003 serial "0000:00:14.0" name "xHCI Host Controller" hash "E8Zs26CP5+JQoiPVmDSuTb4j11VatW+WHlWxiX8+qJc=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
    allow id 1d6b:0002 serial "0000:48:00.0" name "xHCI Host Controller" hash "duKFTytMZb3mxqAV1C/mTjJtsJntA0Bmtz7GMWN7Ezk=" parent-hash "CRH/sbLaSjn0y1+OWdYZYrsDwEJju9nyhjIWNyMCW/Q=" with-interface 09:00:00 with-connect-type ""
    allow id 1d6b:0003 serial "0000:48:00.0" name "xHCI Host Controller" hash "kMEFHAzKLK6hQhh7EzMkdjGPgWawViqo2uLKyK+2U+k=" parent-hash "CRH/sbLaSjn0y1+OWdYZYrsDwEJju9nyhjIWNyMCW/Q=" with-interface 09:00:00 with-connect-type ""

    allow id 27c6:6594 serial "UIDC99E098B_XXXX_MOC_B0" name "Goodix USB2.0 MISC" hash "yezQyb4YO4M5Lx5fqzFBIzaQYoLzui17ZGOggxa1/sQ=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface ff:00:00 with-connect-type "not used"
    allow id 174f:1812 serial "0001" name "Integrated Camera" hash "nxRHHqUkAWERxza+DzyYR8Z/zjOIoMUrbsPJ51CM9Ms=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:01:01 0e:02:01 0e:02:01 0e:02:01 0e:02:01 0e:02:01 0e:02:01 0e:02:01 0e:02:01 fe:01:01 } with-connect-type "not used"
    allow id 8087:0033 serial "" name "" hash "ciwwGozaSw4maEXfs4NdvETeMt6bnFEK6f4vmCqfud0=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" via-port "1-10" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "not used"

    allow id 05e3:0610 serial "" name "USB2.1 Hub" hash "Pc9in9P21U9SqYSsDY1dunP0fyowaT794ozDkz69Gm4=" with-interface { 09:00:01 09:00:02 }
    allow id 1050:0407 serial "" name "YubiKey OTP+FIDO+CCID" hash "2msOvGX5iCToX2LqCqPIO9H6KxlnnkuQgfKCOZkGzNg=" with-interface { 03:01:01 03:00:00 0b:00:00 }
    allow id 046d:c548 serial "" name "USB Receiver" hash "W7/syhaIvf5FH29+W3wAIcjg6d4X2+RQU3lHE5qKlyE=" with-interface { 03:01:01 03:01:02 03:00:00 03:00:00 }
    allow id 3434:0830 serial "" name "Keychron Q3 Max" hash "279UfgQyNiyucw9rFMHrxbBuks1JuB90bDxTGLodG0c=" with-interface { 03:01:01 03:00:00 03:00:00 }

    allow id 1a86:55d3 serial "5A7C121474" name "USB Single Serial" hash "Zbg3nLpDRuxalfMHK7tRZnaJcFBLgHoye6zjKpqhbbs=" with-interface { 02:02:01 0a:00:00 }
  '';
in
{
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    IPCAllowedGroups = [ "wheel" ];
    inherit rules;
  };

  environment.systemPackages = [ pkgs.usbguard-notifier ];
}
