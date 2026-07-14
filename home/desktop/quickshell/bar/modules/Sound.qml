import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Pipewire

import "../constants"

Item {
    id: root
    property var device: Pipewire.defaultAudioSink

    readonly property string volumeIcon: {
        if (!root.device) return "N/A"
        if (!root.device.audio) return "N/A"

        if (root.device.audio.muted) return "󰝟"
        return "󰕾"
    }

    PwObjectTracker {
        objects: root.device ? [root.device] : []
    }

   Rectangle {
        anchors.fill: parent
        color: "transparent"
        Text {
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: Macchiato.text
            text: `${root.volumeIcon} ${root.device ? Math.round(root.device.audio.volume * 100) : "N/A"}%`
        }
    }
}
