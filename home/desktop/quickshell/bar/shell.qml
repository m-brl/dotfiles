import Quickshell
import QtQuick
import QtQuick.Layouts

import "./modules"
import "./services"
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


    ClockWindow {
        id: clockWindow
    }

    NetworkWindow {
        id: networkWindow
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

            Item {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                RowLayout { // left
                    anchors.left: parent.left
                    height: parent.height

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.preferredWidth: hyprlandWS.implicitWidth + 20
                        color: Theme.base0
                        radius: 15

                        HyprlandWS {
                            id: hyprlandWS
                            anchors.fill: parent
                        }
                    }

                    /*Rectangle {
                        Layout.fillHeight: true
                        Layout.preferredWidth: hyprlandWS.implicitWidth + 20
                        color: Theme.base0
                        radius: 15

                        HyprlandMode {
                            id: hyprlandMode
                            anchors.fill: parent
                        }
                    }*/
                }

                RowLayout { // mid
                    anchors.centerIn: parent
                    height: parent.height

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        color: "#2e3440"
                        radius: 15

                        Player {

                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        color: Theme.base0
                        radius: 15

                        Clock {
                            anchors.fill: parent
                        }
                    }
                }

                Rectangle {
                    anchors.right: parent.right
                    height: parent.height
                    color: Theme.base0
                    radius: 15
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
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            radius: 15
                            color: Theme.primary

                            EmailModule {
                                anchors.fill: parent
                                emailService: emailServiceBackend
                            }
                        }

                        Rectangle { // Network
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            radius: 15
                            color: Theme.primary
                            Network {
                                anchors.fill: parent
                            }
                        }

                        Rectangle { // Bluetooth
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            radius: 15
                            color: Theme.primary
                            Bluetooth {
                                anchors.fill: parent
                            }
                        }


                        Rectangle { // Sounrd
                            id: sound
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            radius: 15
                            color: Theme.primary
                            Sound {
                                anchors.fill: parent
                            }
                        }

                        Rectangle {
                            id: battery
                            Layout.preferredWidth: 70
                            Layout.fillHeight: true
                            radius: 15
                            color: Theme.primary

                            Battery {
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
                                anchor.margins.top: 11
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
