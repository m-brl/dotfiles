import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: clockService

    property string tz: "Europe/Paris"
    property date currentDate: new Date()

    property string amPm: Qt.formatDateTime(clockService.currentDate, "AP")

    property string hours: Qt.formatDateTime(clockService.currentDate, "h ap").replace("am", "").replace("pm", "").trim()
    property int minutes: Qt.formatDateTime(clockService.currentDate, "mm")
    property int seconds: Qt.formatDateTime(clockService.currentDate, "ss")

    property int day: Qt.formatDateTime(clockService.currentDate, "dd")
    property string dayOfWeek: Qt.formatDateTime(clockService.currentDate, "dddd")
    property int month: Qt.formatDateTime(clockService.currentDate, "MM")
    property string monthName: Qt.formatDateTime(clockService.currentDate, "MMMM")
    property int year: Qt.formatDateTime(clockService.currentDate, "yyyy")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clockService.currentDate = new Date()
        }
    }
}
