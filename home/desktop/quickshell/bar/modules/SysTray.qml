import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Networking

import "../constants"

Item {
    id: sysTray

    function getFirstConnectedDevice() {
        for (var i = 0; i < Networking.devices.values.length; i++) {
            var device = Networking.devices.values[i]
            if (device.connected) {
                return device
            }
        }
    }
    property var device: getFirstConnectedDevice()

    function getDeviceIcon(device) {
        if (device.type === DeviceType.Wifi) {
            return "\udb81\udda9"
        }
        if (device.type === DeviceType.Wired) {
            return "\udb80\ude00"
        }
        return "\udb80\udf17"
    }

    Rectangle {
        anchors.fill: parent
        radius: 6
        RowLayout {
            anchors.fill: parent
            spacing: 0
            Rectangle {
                Layout.preferredWidth: 40
                Layout.fillHeight: true
                color: Macchiato.base
                Text {
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    font.family: "JetBrainsMono Nerd Font"
                    text: sysTray.device ?
                        `<font color="${Macchiato.rosewater}">${sysTray.getDeviceIcon(sysTray.device)}</font>` : "No Device"
                }
            }
        }
    }
}
