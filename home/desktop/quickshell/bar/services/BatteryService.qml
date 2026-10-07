import QtQuick

import Quickshell.Io
import Quickshell.Services.UPower

import "../constants"

Item {
    id: root

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            tlpStat.running = true
            upower.running = true
        }
    }

    Process {
        id: proc
        stdout: StdioCollector {
            onStreamFinished: {}
        }
    }

    function setPowerProfile(profile) {
        proc.command = ["pkexec", "tlp", profile]
        proc.running = true
        tlpStat.running = true
    }

    Process {
        id: tlpStat
        command: ["tlp-stat", "-s"]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = text.split("\n")
                for (var i = 0; i < lines.length; i++) {
                    var line = lines[i].trim()
                    if (line.startsWith("Power profile")) {
                        var profile = line.split("=")[1].split(":")[0].trim().split("/")[0].trim()
                        root.profile = profile
                    }
                }
            }
        }
        running: true
    }

    Process {
        id: upower
        command: ["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = text.split("\n")
                for (var i = 0; i < lines.length; i++) {
                    var line = lines[i].trim()
                    if (line.startsWith("charge-cycles")) {
                        root.chargeCycles = parseInt(line.split(":")[1].trim())
                    }
                }
            }
        }
    }

    readonly property var devices: UPower.devices.values
    property var profile
    property int chargeCycles: 0
    readonly property var battery: {
        if (root.devices.length === 0) return null
        return devices.find(device => device.type === UPowerDeviceType.Battery)
    }
}
