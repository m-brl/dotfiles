import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.Pipewire

ShellRoot {
    id: root

    property var brightness: 0.5
    property var brightnessMax: 0.5

    IpcHandler {
        target: "brightness-osd"

        function toggle(): void {
            triggerOsd()
        }
    }

    Process {
        id: brightnessReader
        running: true
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                var arr = this.text.trim().split(",")
                root.brightness = parseInt(arr[2])
                root.brightnessMax = parseInt(arr[4])
            }
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
        brightnessReader.running = true
        osdWindow.visible = true
        osdTimer.restart()
    }

    function getBrightnessIcon(brightness) {
        if (brightness < 0.33) {
            return "\udb80\udcde"
        } else if (brightness < 0.66) {
            return "\udb80\udcdf"
        } else {
            return "\udb80\udce0"
        }
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
                    text: root.getBrightnessIcon(root.brightness / root.brightnessMax)
                    color: "#cad3f5"
                }

                Rectangle {
                    width: 140
                    height: 6
                    radius: 3
                    color: "#414559"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        width: root.brightness / root.brightnessMax * parent.width
                        height: parent.height
                        color: "#c6a0f6"
                        radius: 3
                    }
                }
            }
        }
    }
}
