import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Pipewire

ShellRoot {
    id: root

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }
    readonly property var audioSink: Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio

    Timer {
        id: osdTimer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            osdWindow.visible = false;
        }
    }

    Connections {
        target: root.audioSink

        function onVolumeChanged() { triggerOsd() }
        function onMutedChanged() { triggerOsd() }
    }

    function triggerOsd() {
        osdWindow.visible = true
        osdTimer.restart()
    }

    function getVolumeIcon(volume, isMuted) {
        if (isMuted || volume === 0) return "\udb81\udd81"

        if (volume < 0.5) return "\udb81\udd80"
        return "\udb81\udd7e"
    }

    PanelWindow {
        id: osdWindow
        width: 150
        height: 100
        color: "transparent"
        visible: false

        Rectangle {
            anchors.fill: parent
            color: "#24273a"
            radius: 12

            Column {
                anchors.centerIn: parent
                spacing: 30

                Text {
                    id: volumeIcon
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 48
                    width: 48
                    height: 48
                    text: root.audioSink ? root.getVolumeIcon(root.audioSink.volume, root.audioSink.muted) : "\udb81\udd7e"
                    color: "#cad3f5"
                }

                Rectangle {
                    width: 140
                    height: 6
                    radius: 3
                    color: "#414559"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        width: root.audioSink ? (parent.width * Math.min(1, root.audioSink.volume)) : 0
                        height: parent.height
                        color: "#c6a0f6"
                        radius: 3
                    }
                }
            }
        }
    }
}
