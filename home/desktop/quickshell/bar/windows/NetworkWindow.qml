import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Networking
import "../modules"
import "../constants"

PanelWindow {
    id: networkWindow
    color: "transparent"
    implicitWidth: 500
    implicitHeight: 1000

    Component.onCompleted: {
        console.log("init")
        console.log(Networking.devices.values)
        for (var i = 0; i < Networking.devices.values.length; i++) {
            console.log("enabling scanner for device: " + device.name)
            if (Networking.devices[i].type === DeviceType.Wifi) {
                var device = Networking.devices[i]
                device.scannerEnabled = true
            }
        }
    }

    visible: false

    Rectangle {
        width: 250
        height: 325
        anchors.centerIn: parent

        color: Qt.alpha(Frappe.crust, 0.8)
        radius: 50

        ListView {
            anchors.fill: parent
            model: Networking.devices

            delegate: Rectangle {
                id: device

                width: parent.width
                height: 150
                color: "transparent"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        color: "red"
                        Text {
                            anchors.centerIn: parent

                            font.pixelSize: 20
                            font.family: "JetBrainsMono Nerd Font"
                            font.bold: true

                            color: Macchiato.text
                            text: modelData.name
                        }
                    }
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: modelData.networks

                        delegate: Rectangle {
                            width: parent.width
                            height: 40
                            color: "blue"
                            Text {
                                anchors.centerIn: parent

                                font.pixelSize: 18
                                text: ">" + modelData.name
                                color: "white"
                            }
                        }
                    }
                }
            }
        }
    }
}
