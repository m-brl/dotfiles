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
        id: clockService
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
            property var modelData
            id: panelWindow
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            height: 60
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                color: "transparent"
                radius: 6

                RowLayout { // left
                    anchors.left: parent.left
                    height: parent.height

                    Rectangle {
                        Layout.fillHeight: true
                            Layout.preferredWidth: hyprlandWS.implicitWidth + 20
                        color: Macchiato.base
                        radius: 15

                        HyprlandWS {
                            id: hyprlandWS
                            anchors.fill: parent
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
                        color: Macchiato.base
                        radius: 15

                        Player {

                        }
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        color: Macchiato.base
                        radius: 15

                        Clock {
                            anchors.fill: parent
                        }
                    }
                }

                Rectangle {
                    anchors.right: parent.right
                    height: parent.height
                    color: Macchiato.base
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

                        Rectangle { // Network
                            Layout.preferredWidth: 50
                            Layout.fillHeight: true
                            radius: 15
                            color: Macchiato.surface0
                            Network {
                                anchors.fill: parent
                            }
                        }

                        Rectangle { // Bluetooth
                            Layout.preferredWidth: 50
                            Layout.fillHeight: true
                            radius: 15
                            color: Macchiato.surface0
                            Bluetooth {
                                anchors.fill: parent
                            }
                        }


                        Rectangle { // Sounrd
                            Layout.preferredWidth: 80
                            Layout.fillHeight: true
                            radius: 15
                            color: Macchiato.surface0
                            Sound {
                                anchors.fill: parent
                            }
                        }

                        Rectangle {
                            Layout.preferredWidth: 80
                            Layout.fillHeight: true
                            radius: 15
                            color: Macchiato.surface0

                            Battery {
                                anchors.fill: parent
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: clockWindow.toggle()
                            }
                        }

                    }
                }
            }
        }
    }


}
