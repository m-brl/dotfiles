import QtQuick
import QtQuick.Layouts

import Quickshell
import "../modules"
import "../constants"

PanelWindow {
    id: clockWindow
    color: "transparent"
    implicitWidth: 1000
    implicitHeight: 1000

    visible: false

    property bool active: false

    property bool anim

    function toggle() {
        if (clockWindow.active) {
            clockWindow.deactivate() 
        } else {
            clockWindow.activate()
        }
    }

    function activate() {
        clockWindow.anim = true
        clockWindow.visible = true
        clockWindow.active = true
    }

    function deactivate() {
        clockWindow.anim = false;
        hideTimer.start()
        clockWindow.active = false
    }

    Timer {
        id: hideTimer
        interval: 300
        onTriggered: clockWindow.visible = false
    }

    Rectangle {
        width: 250
        height: 325
        anchors.centerIn: parent

        color: Qt.alpha(Frappe.crust, 0.8)
        radius: 50

        scale: clockWindow.anim ? 1.0 : 0.3
        opacity: clockWindow.anim ? 1.0 : 0.0

        Behavior on scale {
            NumberAnimation { duration: 300; easing.type: Easing.OutBack; easing.overshoot: 1.5 }
        }
        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }

        ColumnLayout {
            anchors.fill: parent

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 225
                color: "transparent"
                AnalogClock {
                    anchors.centerIn: parent
                    second: 0 //clockService.seconds
                    minute: clockService.minutes
                    hour: clockService.hours
                }
            }
            Rectangle {
                Layout.preferredWidth: 175
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    Rectangle {
                        id: dayContainer
                        Layout.preferredHeight: 48
                        Layout.preferredWidth: 64
                        color: "transparent"
                        Text {
                            id: dayText
                            anchors.centerIn: parent
                            color: Frappe.text
                            font.pixelSize: 48
                            font.bold: true

                            text: String(clockService.day).padStart(2, "0")
                        }
                    }
                    Rectangle {
                        Layout.preferredHeight: 48
                        Layout.fillWidth: true
                        color: "transparent"
                        Column {
                            anchors.fill: parent
                            Text {
                                color: Frappe.green
                                font.pixelSize: 20
                                font.bold: true
                                text: clockService.dayOfWeek
                            }
                            Text {
                                font.pixelSize: 14
                                color: Frappe.surface2
                                text: clockService.monthName + " " + String(clockService.year).padStart(4, "0")
                                anchors.baseline: dayText.baseline
                            }
                        }
                    }
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: clockWindow.deactivate()
    }
}
