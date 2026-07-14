import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Bluetooth

import "../constants"

Item {
    id: root
    property var device: Bluetooth.defaultAdapter

    readonly property string bluetoothIcon: {
        if (!root.device) return "󰂲"
        if (!root.device.enabled) return "󰂲"
        let connectedDevices = root.device.devices.values.filter(d => d.connected)
        if (connectedDevices.length == 0) return "󰂯"
        return "󰂱"
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Text {
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: Macchiato.blue
            text: root.bluetoothIcon
        }
    }
}
