{ config, lib, pkgs, ... }:


let
  tlp = config.services.tlp.package;

  tlpPolicy = pkgs.writeTextDir "share/polkit-1/actions/org.mathieu.tlp.policy" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC
     "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
     "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">
    <policyconfig>
      <action id="org.mathieu.tlp.run">
        <description>Lancer monapp avec les privilèges root</description>
        <message>Authentification requise pour lancer monapp</message>
        <defaults>
          <allow_any>no</allow_any>
          <allow_inactive>no</allow_inactive>
          <allow_active>auth_admin_keep</allow_active>
        </defaults>
        <annotate key="org.freedesktop.policykit.exec.path">${tlp}/bin/tlp</annotate>
        <annotate key="org.freedesktop.policykit.exec.allow_gui">true</annotate>
      </action>
    </policyconfig>
  '';
in
{
  environment.systemPackages = [ tlpPolicy ];
}
