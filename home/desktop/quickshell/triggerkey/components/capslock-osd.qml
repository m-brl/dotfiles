import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.Pipewire

ShellRoot {
    id: root

    property var caps: 0

    IpcHandler {
        target: "capslock-osd"

        function toggle(value: int): void {
            root.caps = value
            triggerOsd()
        }
    }

    Timer {
        id: osdTimer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            osdWindow.visible = false;
        }
    }

    function triggerOsd() {
        osdWindow.visible = true
        osdTimer.restart()
    }

    PanelWindow {
        id: osdWindow
        margins.bottom: 50
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
                    text: "\udb81\ude32"
                    color: root.caps ? "#ccd0da" : "#4c4f69"
                }

                Text {
                    text: "Caps Lock"
                    color: root.caps ? "#c6a0f6" : "#4c4f69"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
