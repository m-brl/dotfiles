import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Wayland

import "../constants"
import "../components"
import "../services"
import "../utils.js" as Utils

PopupWindow {
    id: root

    required property BatteryService batteryService

    enum RingMode {
        Battery,
        Fan
    }
    property int mode: BatteryWindow.RingMode.Fan

    readonly property var profiles: [
        {
            name: "performance",
            label: "󰈐 Perform"
        },
        {
            name: "balanced",
            label: "󰗑 Balance"
        },
        {
            name: "power-saver",
            label: "󰌪 Saver"
        }
    ]
    readonly property int currentIndex: profiles.findIndex(p => p.name === root.batteryService.shownProfile)

    visible: false
    color: "transparent"
    width: 410
    height: 500

    property bool anim: false

    function toggle() {
        if (root.anim) {
            root.deactivate();
        } else {
            root.activate();
        }
    }

    function activate() {
        root.anim = true;
        root.visible = true;
    }

    function deactivate() {
        root.anim = false;
        hideTimer.start();
    }

    Timer {
        id: hideTimer
        interval: 200
        onTriggered: root.visible = false
    }

    readonly property string stateText: {
        switch (root.batteryService.battery.state) {
        case UPowerDeviceState.Empty:
            return "Empty";
        case UPowerDeviceState.Discharging:
            return "Discharging";
        case UPowerDeviceState.PendingCharge:
            return "Pending Charge";
        case UPowerDeviceState.Unknown:
            return "Unknown";
        case UPowerDeviceState.PendingDischarge:
            return "Pending Discharge";
        case UPowerDeviceState.Charging:
            return "Charging";
        case UPowerDeviceState.FullyCharged:
            return "Fully Charged";
        }
    }

    property real animatedValue: {
        switch (root.mode) {
            case BatteryWindow.RingMode.Battery:
                return root.batteryService.battery.percentage
            case BatteryWindow.RingMode.Fan:
                return root.batteryService.fanSpeed * 100 / 917400
        }
    }

    Behavior on animatedValue {
        NumberAnimation {
            duration: 1200
            easing.type: Easing.OutCubic
        }
    }

    readonly property string timeRemainingText: {
        var battery = root.batteryService.battery;
        if (!battery)
        return "";

        if (battery.state === UPowerDeviceState.Charging && battery.timeToFull > 0)
        return Utils.formatDuration(battery.timeToFull) + " until full";
        if (battery.state === UPowerDeviceState.Discharging && battery.timeToEmpty > 0)
        return Utils.formatDuration(battery.timeToEmpty) + " remaining";
        return "";
    }

    Item {
        id: popupContent
        anchors.fill: parent
        anchors.topMargin: 10

        transformOrigin: Item.Top
        scale: root.anim ? 1.0 : 0.85
        opacity: root.anim ? 1.0 : 0.0

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutBack
                easing.overshoot: 1.3
            }
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }

        Rectangle {
            id: background
            anchors.fill: parent
            radius: 15
            color: Theme.base0
        }

        MouseArea {
            anchors.fill: background
            onClicked: {
                root.toggle();
            }
        }

        ColumnLayout {
            id: content
            anchors.fill: parent

            RowLayout { // RING
                Layout.fillWidth: true
                Layout.preferredHeight: 250

                Item {
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    Text {
                        anchors.centerIn: parent
                        font.family: Theme.fontFamily
                        font.pixelSize: 20
                        color: Theme.text
                        text: "󰁍"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.mode = (root.mode + 1) % 2
                        }
                    }
                }

                RingComponent { // battery
                    Layout.fillWidth: true
                    Layout.preferredHeight: 250
                    visible: root.mode === BatteryWindow.RingMode.Battery
                    value: root.animatedValue
                    title: "󰁹 " + Math.round(root.animatedValue * 100) + "%"
                    subtitle: root.stateText.toUpperCase()
                    content: root.timeRemainingText
                }

                RingComponent { // fan speed
                    Layout.fillWidth: true
                    Layout.preferredHeight: 250
                    visible: root.mode === BatteryWindow.RingMode.Fan
                    value: root.animatedValue
                    title: "󰈐 " + Math.round(root.animatedValue * 100) + "%"
                    subtitle: `${root.batteryService.fanSpeed} RPM`
                }

                Item {
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    Text {
                        anchors.centerIn: parent
                        font.family: Theme.fontFamily
                        font.pixelSize: 20
                        color: Theme.text
                        text: "󰁔"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.mode = (root.mode + 1) % 2
                        }
                    }
                }
            }

            SteppedSlider {
                id: fanSpeedSlider
                visible: root.mode === BatteryWindow.RingMode.Fan
                Layout.preferredWidth: 300
                Layout.preferredHeight: 30
                Layout.alignment: Qt.AlignHCenter
                value: root.batteryService.fanLevel
                steps: 8

                onMoved: {
                    if (value === 8) {
                        Quickshell.execDetached(["sh", "-c", `pkexec fan-control disengaged`])
                    } else {
                        Quickshell.execDetached(["sh", "-c", `pkexec fan-control ${value}`])
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
                            {
                                icon: "󰌾",
                                label: "Lock",
                                action: "loginctl lock-session"
                            },
                            {
                                icon: "󰒲",
                                label: "Sleep",
                                action: "systemctl suspend"
                            },
                            {
                                icon: "󰜉",
                                label: "Reboot",
                                action: "systemctl reboot"
                            },
                            {
                                icon: "󰐥",
                                label: "Shutdown",
                                action: "systemctl poweroff"
                            }
                        ]

                        Rectangle {
                            required property var modelData

                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            radius: 5
                            color: actionButtonMA.containsMouse ? Qt.darker(Theme.base3, 1.2) : Theme.base3
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
                                onClicked: Quickshell.execDetached(modelData.action)
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
                radius: 5

                Rectangle {
                    width: 120
                    radius: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    color: Theme.primary
                    x: root.currentIndex * (120)

                    Behavior on x {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.OutBack
                        }
                    }

                }

                RowLayout {
                    id: powerMode
                    anchors.fill: parent

                    Repeater {
                        id: profileSwitcher

                        model: root.profiles

                        Rectangle {
                            required property var modelData

                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            radius: 25
                            color: "transparent"

                            Behavior on color {
                                ColorAnimation {
                                    duration: 400
                                }
                            }

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
                                    root.batteryService.setPowerProfile(modelData.name);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
