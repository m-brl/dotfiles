import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Pipewire

import "../services"
import "../components"

IconButton {
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

    value: `${root.volumeIcon} ${root.device ? Math.round(root.device.audio.volume * 100) : "N/A"}%`
}
