import QtQuick

import "../services"
import "../constants"

Item {
    id: root
    required property BatteryService batteryService
    visible: false

    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.base3
        radius: 15
    }

    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: Theme.text
            text: `Health: ${root.batteryService.battery.healthPercentage}%`
        }
        Text {
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: Theme.text
            text: `Charge rate: ${root.batteryService.battery.changeRate}W`
        }
        Text {
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: Theme.text
            text: `Nb cycles: ${root.batteryService.chargeCycles} cycles`
        }

    }
}
