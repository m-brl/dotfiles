{ config, lib, pkgs, ... }:

let
  fanControl = pkgs.writeShellScriptBin "fan-control" ''
    echo "watchdog 120" > /proc/acpi/ibm/fan
    case "$1" in
      auto|disengaged|full-speed|[0-7])
        echo "level $1" > /proc/acpi/ibm/fan
        ;;
      *)
        echo "Usage: fan-control {auto|0-7|full-speed|disengaged}" >&2
        exit 1
        ;;
    esac
  '';

  fanControlPolicy = pkgs.writeTextDir "share/polkit-1/actions/org.mathieu.fan.policy" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC
     "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
     "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">
    <policyconfig>
      <action id="org.mathieu.fan.control">
        <description>Set fan mode</description>
        <message>Authentification requise pour lancer monapp</message>
        <defaults>
          <allow_any>no</allow_any>
          <allow_inactive>no</allow_inactive>
          <allow_active>auth_admin_keep</allow_active>
        </defaults>
        <annotate key="org.freedesktop.policykit.exec.path">${lib.getExe fanControl}</annotate>
      </action>
    </policyconfig>
  '';
in
{
  environment.systemPackages = [ fanControl fanControlPolicy ];
}
