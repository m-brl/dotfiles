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

PanelWindow {
    id: root

    width: 150
    height: 100
    color: "transparent"
    visible: false

    required property AudioService audioService

    function triggerOsd() {
        root.visible = true
        osdTimer.restart()
    }

    Timer {
        id: osdTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            root.visible = false;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.base1
        radius: 12
    }

    Column {
        anchors.centerIn: parent
        spacing: 30

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 48
            width: 48
            height: 48
            text: root.audioSink ? root.getVolumeIcon(root.audioSink.volume, root.audioSink.muted) : "\udb81\udd7e"
            color: Theme.primary
        }

        Rectangle {
            width: 140
            height: 5
            radius: 3
            color: Theme.base3

            Rectangle {
                width: (root.audioService.volume * parent.width)
                height: parent.height
                radius: 3
                color: Theme.primary
            }
        }
    }
}
