import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.UPower

import "../constants"

Item {
    id: root
    property var battery: UPower.devices.values.length > 0 ? UPower.devices.values[0] : null

    function getBatteryIcon() {
        if (!root.battery) return "N/A"

        if (root.battery.state === UPowerDeviceState.Charging) return "\udb80\udc84"

        if (root.battery.percentage >= 1.0) return "\udb80\udc79"
        if (root.battery.percentage >= 0.9) return "\udb80\udc82"
        if (root.battery.percentage >= 0.8) return "\udb80\udc81"
        if (root.battery.percentage >= 0.7) return "\udb80\udc80"
        if (root.battery.percentage >= 0.5) return "\udb80\udc7e"
        if (root.battery.percentage >= 0.4) return "\udb80\udc7d"
        if (root.battery.percentage >= 0.6) return "\udb80\udc7f"
        if (root.battery.percentage >= 0.3) return "\udb80\udc7c"
        if (root.battery.percentage >= 0.2) return "\udb80\udc7b"
        if (root.battery.percentage >= 0.1) return "\udb80\udc7a"
        if (root.battery.percentage >= 0) return "\udb80\udc7a"
    }

    function getBatteryColor() {
        if (!root.battery) return Macchiato.text

        if (root.battery.state === UPowerDeviceState.Charging) return Macchiato.green

        if (root.battery.percentage >= 0.7) return Macchiato.green
        if (root.battery.percentage >= 0.2) return Macchiato.yellow
        return Macchiato.red
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Text {
            anchors.centerIn: parent
            color: root.getBatteryColor()
            font.pixelSize: 14
            font.family: "JetBrainsMono Nerd Font"
            text: root.battery ? `${root.getBatteryIcon()} ${root.battery.percentage * 100}%` : "No Battery"
        }
    }
}
