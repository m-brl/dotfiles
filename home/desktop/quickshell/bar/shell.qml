import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "./modules"
import "./components"
import "./services"
import "./osd"
import "./windows"
import "./constants"

ShellRoot {
    id: root

    ClockService {
        id: clockServiceBackend
    }

    BatteryService {
        id: batteryServiceBackend
    }

    EmailService {
        id: emailServiceBackend
    }

    AudioService {
        id: audioServiceBackend
        onVolumeChanged: {
            soundOsd.triggerOsd()
        }
    }

    SoundOsd {
        id: soundOsd
        audioService: audioServiceBackend
    }


    ClockWindow {
        id: clockWindow
    }

    NetworkWindow {
        id: networkWindow
    }

    ClipboardWindow {
        id: clipboardWindow
        clipboardService: ClipboardService {

        }
    }

    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            id: panelWindow

            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            height: 60
            color: "transparent"

            Item { // full bar
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                RowLayout { // left
                    anchors.left: parent.left
                    height: parent.height

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.preferredWidth: hyprlandWSModule.implicitWidth + 20
                        color: Theme.base0
                        radius: 5

                        HyprlandWSModule {
                            id: hyprlandWSModule
                            anchors.fill: parent
                        }
                    }

                    Rectangle {
                        id: mic

                        Layout.fillHeight: true
                        Layout.preferredWidth: 50
                        color: Theme.base0
                        radius: 5
                        visible: audioServiceBackend.isMicInUse

                        Text {
                            anchors.centerIn: parent
                            text: "󰍬"
                            color: Theme.red
                            font.pixelSize: 20
                            font.family: Theme.fontFamily
                        }
                    }
                }

                RowLayout { // mid
                    anchors.centerIn: parent
                    height: parent.height

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        color: Theme.base0
                        radius: 5

                        PlayerModule {

                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        color: Theme.base0
                        radius: 5

                        ClockModule {
                            anchors.fill: parent
                            clockService: clockServiceBackend
                        }
                    }
                }

                Rectangle { // right
                    anchors.right: parent.right
                    height: parent.height
                    color: Theme.base0
                    radius: 5
                    width: rightLayout.implicitWidth + 20

                    RowLayout { // right
                        id: rightLayout

                        spacing: 10
                        anchors.fill: parent
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10

                        Rectangle {
                            Layout.preferredWidth: 100
                            Layout.fillHeight: true
                            radius: 5
                            color: Theme.primary

                            EmailModule {
                                anchors.fill: parent
                                emailService: emailServiceBackend
                            }
                        }

                        Item { // Network
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true

                            NetworkModule {
                                id: networkModule
                                anchors.fill: parent
                            }

                            Tooltip {
                                id: networkTooltip
                                text: networkModule.device.networks.values[0].signalStrength
                                visible: networkModule.hovered
                                anchor.item: networkModule
                                anchor.edges: Edges.Bottom
                                anchor.gravity: Edges.Bottom
                            }
                        }

                        Item { // Bluetooth
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true

                            BluetoothModule {
                                anchors.fill: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    Quickshell.execDetached("blueman-manager")
                                }
                            }
                        }


                        Item { // Sound
                            id: sound
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true

                            SoundModule {
                                anchors.fill: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    Quickshell.execDetached("pavucontrol")
                                }
                            }
                        }

                        Item { // battery
                            id: battery
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true

                            BatteryModule {
                                anchors.fill: parent
                                batteryService: batteryServiceBackend
                            }

                            BatteryWindow {
                                id: batteryWindow
                                batteryService: batteryServiceBackend

                                anchor.window: panelWindow
                                anchor.item: battery
                                anchor.edges: Edges.Bottom | Edges.Right
                                anchor.gravity: Edges.Bottom | Edges.Left
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    batteryWindow.toggle()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
