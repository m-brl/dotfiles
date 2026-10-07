import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Wayland

import "../constants"
import "../services"
import "../utils.js" as Utils

PopupWindow {
    id: root

    required property BatteryService batteryService

    visible: false
    color: "transparent"
    width: 410
    height: 500

    function toggle() {
        root.visible = !root.visible
    }

    readonly property string stateText: {
        switch (root.batteryService.battery.state) {
            case UPowerDeviceState.Empty: return "Empty"
            case UPowerDeviceState.Discharging: return "Discharging"
            case UPowerDeviceState.PendingCharge: return "Pending Charge"
            case UPowerDeviceState.Unknown: return "Unknown"
            case UPowerDeviceState.PendingDischarge: return "Pending Discharge"
            case UPowerDeviceState.Charging: return "Charging"
            case UPowerDeviceState.FullyCharged: return "Fully Charged"
        }
    }

    property real animatedValue: {
        root.batteryService.battery.percentage
    }

    readonly property string timeRemainingText: {
        var battery = root.batteryService.battery
        if (!battery) return ""

        if (battery.state === UPowerDeviceState.Charging && battery.timeToFull > 0)
            return Utils.formatDuration(battery.timeToFull) + " until full"
        if (battery.state === UPowerDeviceState.Discharging && battery.timeToEmpty > 0)
            return Utils.formatDuration(battery.timeToEmpty) + " remaining"
        return ""
    }

    Behavior on animatedValue {
        NumberAnimation {
            duration: 1200
            easing.type: Easing.OutCubic
        }
    }

    Process {
        id: cmdRunner
    }

    function exec(command) {
        cmdRunner.command = ["sh", "-c", command]
        cmdRunner.running = true
    }


    Item {
        anchors.fill: parent
        anchors.topMargin: 10

        Rectangle {
            id: background
            anchors.fill: parent
            radius: 15
            color: Theme.base0
        }

        MouseArea {
            anchors.fill: background
            onClicked: {
                root.toggle()
            }
        }
    }

    ColumnLayout {
        id: content
        anchors.fill: parent
        

        Item { // canvas
            Layout.fillWidth: true
            Layout.preferredHeight: 250

            Rectangle { // background
                anchors.centerIn: parent
                width: 250
                height: 250
                radius: 125
                color: Theme.base0
            }

            Shape {
                id: ring
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 4

                ShapePath {
                    strokeColor: Theme.base3
                    strokeWidth: 10
                    fillColor: "transparent"

                    PathAngleArc {
                        centerX: ring.width /2
                        centerY: ring.height /2
                        radiusX: 110; radiusY: 110
                        startAngle: -90
                        sweepAngle: 360
                    }
                }

                ShapePath {
                    strokeColor: Theme.primary
                    strokeWidth: 10
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        centerX: ring.width / 2
                        centerY: ring.height / 2
                        radiusX: 110; radiusY: 110
                        startAngle: -90
                        sweepAngle: root.animatedValue * 360
                    }
                }
            }

            Column {
                anchors.centerIn: parent

                Text {
                    id: percentageText
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: "󰁹 " + Math.round(root.animatedValue * 100) + "%"
                    font.pixelSize: 48
                    font.bold: true
                    font.family: "JetBrainsMono Nerd Font"
                    color: Theme.text
                }
                Text {
                    id: statusText
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: root.stateText.toUpperCase()
                    font.pixelSize: 18
                    font.family: "JetBrainsMono Nerd Font"
                    color: Theme.text
                }
                Text {
                    id: timeRemainingLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: root.timeRemainingText.length > 0

                    text: root.timeRemainingText
                    font.pixelSize: 13
                    font.family: "JetBrainsMono Nerd Font"
                    color: Theme.text
                    opacity: 0.7
                }
            }
        }

        Rectangle { // stats
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            Layout.leftMargin: 25
            Layout.rightMargin: 25
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                spacing: 12

                Repeater {
                    model: [
                        {
                            icon: "♥",
                            label: "Health",
                            value: root.batteryService.battery.healthSupported
                                ? Math.round(root.batteryService.battery.healthPercentage) + "%"
                                : "N/A"
                        },
                        {
                            icon: "⚡",
                            label: "Rate",
                            value: Math.abs(root.batteryService.battery.changeRate).toFixed(1) + "W"
                        },
                        {
                            icon: "↻",
                            label: "Cycles",
                            value: String(root.batteryService.chargeCycles)
                        }
                    ]

                    Rectangle {
                        required property var modelData

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 15
                        color: Theme.base3

                        Column {
                            anchors.centerIn: parent
                            spacing: 2

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                color: Theme.text
                                text: modelData.icon + " " + modelData.value
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 11
                                color: Theme.text
                                opacity: 0.7
                                text: modelData.label.toUpperCase()
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            Layout.leftMargin: 25
            Layout.rightMargin: 25
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                spacing: 20

                Repeater {
                    model: [
                        { icon: "󰌾", label: "Lock", action: "loginctl lock-session" },
                        { icon: "󰒲", label: "Sleep", action: "systemctl suspend" },
                        { icon: "󰜉", label: "Reboot", action: "systemctl reboot" },
                        { icon: "󰐥", label: "Shutdown", action: "systemctl poweroff" }
                    ]

                    Rectangle {
                        required property var modelData

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 15
                        color: actionButtonMA.containsMouse ? Theme.base0 : Theme.base3
                        Column {
                            anchors.centerIn: parent

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: "JetBrainsMono Nerd Font"
                                font.bold: true
                                font.pixelSize: 20
                                color: Theme.text
                                text: modelData.icon
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 14
                                color: Theme.text
                                text: modelData.label
                            }
                        }
                        MouseArea {
                            id: actionButtonMA
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: root.exec(modelData.action)
                        }
                    }
                }
            }
        }

        Rectangle { // mode
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            Layout.leftMargin: 25
            Layout.rightMargin: 25

            color: Theme.base3
            radius: 25

            RowLayout {
                id: powerMode
                anchors.fill: parent

                Repeater {
                    model: [
                        { name: "performance", label: "󰈐 Perform" },
                        { name: "balanced", label: "󰗑 Balance" },
                        { name: "power-saver", label: "󰌪 Saver" }
                    ]

                    Rectangle {
                        required property var modelData

                        Layout.preferredHeight: 50
                        Layout.fillWidth: true
                        radius: 25
                        color: root.batteryService.profile === modelData.name ? Theme.primary : Theme.base3
                        Text {
                            anchors.centerIn: parent
                            font.family: "JetBrainsMono Nerd Font"
                            font.bold: true
                            font.pixelSize: 14
                            color: Theme.text
                            text: modelData.label
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                root.batteryService.setPowerProfile(modelData.name)
                            }
                        }
                    }
                }
            }
        }
    }
}
