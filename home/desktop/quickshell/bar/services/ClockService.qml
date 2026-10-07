import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: clockService

    property string tz: "Europe/Paris"

    property int hour24: 0
    property int minutes: 0
    property int seconds: 0
    property int day: 1
    property int month: 1
    property int year: 1970

    readonly property string amPm: clockService.hour24 < 12 ? "AM" : "PM"
    readonly property string hours: String(clockService.hour24 % 12 === 0 ? 12 : clockService.hour24 % 12)

    readonly property int weekdayIndex: new Date(clockService.year, clockService.month - 1, clockService.day).getDay()
    readonly property string dayOfWeek: Qt.locale().dayName(clockService.weekdayIndex === 0 ? 7 : clockService.weekdayIndex, Locale.LongFormat)
    readonly property string monthName: Qt.locale().monthName(clockService.month - 1, Locale.LongFormat)

    Process {
        id: dateProc
        command: ["env", "TZDIR=/etc/zoneinfo", "TZ=" + clockService.tz, "date", "+%H|%M|%S|%d|%m|%Y"]
        stdout: StdioCollector {
            onStreamFinished: {
                var fields = text.trim().split("|")
                clockService.hour24 = parseInt(fields[0], 10)
                clockService.minutes = parseInt(fields[1], 10)
                clockService.seconds = parseInt(fields[2], 10)
                clockService.day = parseInt(fields[3], 10)
                clockService.month = parseInt(fields[4], 10)
                clockService.year = parseInt(fields[5], 10)
            }
        }
    }

    Component.onCompleted: dateProc.running = true

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateProc.running = true
        }
    }
}
