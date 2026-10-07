import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Bluetooth

import "../services"
import "../components"

IconButton {
    id: root
    property var device: Bluetooth.defaultAdapter

    readonly property string bluetoothIcon: {
        if (!root.device) return "󰂲"
        if (!root.device.enabled) return "󰂲"
        let connectedDevices = root.device.devices.values.filter(d => d.connected)
        if (connectedDevices.length == 0) return "󰂯"
        return "󰂱"
    }

    value: root.bluetoothIcon
}
