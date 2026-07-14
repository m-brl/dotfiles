import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Networking

import "../constants"

Item {
    id: root
    property var devices: Networking.devices
    readonly property var device: {
        var tmp = root.devices.values.find(d => d.connected && (d.type === DeviceType.Wired))
        if (tmp) return tmp
        return root.devices.values.find(d => d.connected) || null
    }
    readonly property var network: {
        if (!root.device) return null
        var device = root.device.networks.values.find(n => n.connected) || null
        return device
    }

    readonly property string networkIcon: {
        if (!root.device) return "N/A"
        if (root.device.type === DeviceType.Wired) return "󰈀"
        if (root.device.type === DeviceType.Wifi) {
            if (root.network.signalStrength >= 75) return "󰤨"
            if (root.network.signalStrength >= 50) return "󰤥"
            if (root.network.signalStrength >= 25) return "󰤢"
            if (root.network.signalStrength >= 0) return "󰤟"
            console.log(">", root.network)
            return "A"
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Text {
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: Macchiato.blue
            text: root.networkIcon
        }
    }
}
