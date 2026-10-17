import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

import "../constants"

Item {
    id: root

    property string profile: ""
    property string pendingProfile: ""
    property string shownProfile: pendingProfile !== "" ? pendingProfile : profile

    readonly property var devices: UPower.devices.values
    property int chargeCycles: 0
    readonly property var battery: {
        if (root.devices.length === 0) return null
        return devices.find(device => device.type === UPowerDeviceType.Battery)
    }

    property int fanSpeed: 0
    property int fanLevel: 0

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            tlpStat.running = true
        }
    }

    function setPowerProfile(profile) {
        if (tlpSet.running) return
        root.pendingProfile = profile
        tlpSet.profile = profile
        tlpSet.running = true
    }

    Process {
        id: tlpSet
        property string profile: ""
        command: ["tlpctl", profile]
        onExited: (exitCode) => {
            if (exitCode === 0) {
                root.profile = root.pendingProfile
            }
            root.pendingProfile = ""
            tlpStat.running = true
        }
    }

    Process {
        id: tlpStat
        command: ["tlp-stat", "-s"]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = text.split("\n")
                for (var i = 0; i < lines.length; i++) {
                    var line = lines[i].trim()
                    if (line.startsWith("TLP profile")) {
                        var profile = line.split("=")[1].split(":")[0].trim().split("/")[0].trim()
                        root.profile = profile
                    }
                }
            }
        }
        running: true
    }

    Process {
        id: fan
        command: ["sh", "-c", "cat /proc/acpi/ibm/fan"]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = text.split("\n")
                var statusLine = lines.find(line => line.startsWith("status"))
                var speedLine = lines.find(line => line.startsWith("speed"))
                var levelLine = lines.find(line => line.startsWith("level"))

                var status = statusLine.split(":")[1].trim()
                var speed = speedLine.split(":")[1].trim()
                var level = levelLine.split(":")[1].trim()
                root.fanSpeed = parseInt(speed)
                root.fanLevel = parseInt(level)
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            fan.running = true
        }
    }
}
