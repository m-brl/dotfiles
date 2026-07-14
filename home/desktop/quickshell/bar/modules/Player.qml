import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris

import "../constants"

import "../utils.js" as Utils

Item {
    id: root
    property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    anchors.fill: parent
    anchors.centerIn: parent

    Timer {
        running: player && player.isPlaying
        interval: 1000
        repeat: true
        onTriggered: {
            if (root.player) {
                root.player.positionChanged()
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        color: "transparent"
        radius: 15
        
        RowLayout { // player name
            anchors.fill: parent
            spacing: 5

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 40
                color: "transparent"
                rotation: 0

                ClippingWrapperRectangle {
                    id: disk
                    anchors.fill: parent
                    radius: 20
                    Image {
                        anchors.fill: parent
                        source: player ? player.trackArtUrl : ""
                        fillMode: Image.PreserveAspectCrop
                        visible: true
                    }
                }
                RotationAnimation on rotation {
                    from: parent.rotation
                    to: parent.rotation + 360
                    duration: 5000
                    loops: Animation.Infinite
                    running: {
                        console.log(parent.rotation)
                        return player && player.isPlaying
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "transparent"

                ColumnLayout {
                    anchors.fill: parent
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            text: player ? Utils.sliceText(player.trackTitle, 7) + " - " +
                                Utils.sliceText(player.trackArtists, 5) : "No Player"

                            color: Macchiato.sapphire
                            font.pixelSize: 14
                            font.bold: true
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log(player.trackArtUrl)
                                if (root.player)
                                    root.player.raise()
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            text: player ? 
                                Utils.getMinute(player.position) + ":" + Utils.getSecond(player.position) + " / " + Utils.getMinute(player.length) + ":" + Utils.getSecond(player.length) : "0:00"

                            color: Macchiato.text
                            font.pixelSize: 14
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log(player.trackArtUrl)
                                if (root.player)
                                    root.player.raise()
                            }
                        }
                    }

                }
            }

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 2

                Rectangle { // previous
                    Layout.fillHeight: true
                    Layout.preferredWidth: 15
                    Layout.topMargin: 1
                    Layout.bottomMargin: 1

                    color: clickArea0.containsMouse ? Macchiato.surface0 : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "\udb81\udcae"
                        color: root.player && root.player.canGoPrevious ? Macchiato.text : "grey"
                        font.pixelSize: 18
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: clickArea0
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (root.player) {
                                root.player.previous()
                            }
                        }
                    }
                }

                Rectangle { // play-pause
                    Layout.fillHeight: true
                    Layout.preferredWidth: 15
                    Layout.topMargin: 1
                    Layout.bottomMargin: 1
                    color: clickArea2.containsMouse ? Macchiato.surface0 : "transparent"


                    Text {
                        anchors.centerIn: parent
                        text: root.player && root.player.isPlaying ? "\udb80\udfe4" : "\udb81\udc0a"
                        color: root.player && root.player.canTogglePlaying ? Macchiato.text : "grey"
                        font.pixelSize: 18
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: clickArea2
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (root.player) {
                                root.player.togglePlaying()
                            }
                        }
                    }
                }

                Rectangle { // next
                    Layout.fillHeight: true
                    Layout.preferredWidth: 15
                    Layout.topMargin: 1
                    Layout.bottomMargin: 1
                    Layout.rightMargin: 1
                    radius: 6

                    color: clickArea3.containsMouse ? Macchiato.surface0 : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "\udb81\udcad"
                        color: root.player && root.player.canGoNext ? Macchiato.text : "grey"
                        font.pixelSize: 18
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: clickArea3
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (root.player) {
                                root.player.togglePlaying()
                            }
                        }
                    }
                }
            }
        }
    }
}
