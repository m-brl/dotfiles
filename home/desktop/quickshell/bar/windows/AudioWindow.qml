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

    required property AudioService audioService

    visible: false
    color: "transparent"
    width: 300
    height: 500

    function toggle() {
        root.visible = !root.visible
    }

    Item {
        anchors.fill: parent
        anchors.topMargin: 10

        Rectangle {
            id: background
            anchors.fill: parent
            radius: 5
            color: Theme.base0
        }

        MouseArea {
            anchors.fill: background
            onClicked: {
                root.toggle()
            }
        }

        Item {
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            ColumnLayout {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 10

                Repeater { // Source
                    anchors.fill: parent
                    model: audioService.activeSourceOutputs

                    delegate: Rectangle {
                        width: parent.width
                        height: 50
                        radius: 5
                        color: Theme.primary1

                        Text {
                            color: Theme.text
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            text: modelData.name
                        }

                        RowLayout {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            spacing: 10

                            Rectangle {
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 40
                                color: micMuteButton.containsMouse ? Theme.base3 : Theme.base1
                                radius: 5

                                Text {
                                    anchors.centerIn: parent
                                    color: Theme.text
                                    text: modelData.mute ? "󰍭" : "󰍬"
                                    font.pixelSize: 20
                                }

                                MouseArea {
                                    id: micMuteButton
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        audioService.toggleSourceMute(modelData.index)
                                    }
                                }
                            }
                        }
                    }
                }


                Repeater { // Sink
                    anchors.fill: parent
                    model: audioService.activeSinkInputs

                    delegate: Rectangle {
                        width: parent.width
                        height: 50
                        radius: 5
                        color: Theme.primary1

                        Text {
                            color: Theme.text
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            text: modelData.name
                        }

                        RowLayout {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            spacing: 10

                            Rectangle {
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 40
                                color: soundMuteButton.containsMouse ? Theme.base3 : Theme.base1
                                radius: 5

                                Text {
                                    anchors.centerIn: parent
                                    color: Theme.text
                                    text: modelData.mute ? "󰖁" : "󰕾"
                                    font.pixelSize: 20
                                }

                                MouseArea {
                                    id: soundMuteButton
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        audioService.toggleSinkMute(modelData.index)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
