import QtQuick

import "../constants"

Item {
    id: root
    width: 200
    height: 200

    property int hour: 10
    property int minute: 29
    property int second: 45

    Rectangle {
        anchors.fill: parent
        anchors.centerIn: parent
        color: "transparent"
        radius: width / 2
        border.width: 1
        border.color: Qt.alpha(Frappe.overlay0, 0.5)

        Rectangle { // second
            id: secondHand
            width: 2
            height: root.width / 2.5
            radius: 1
            anchors.centerIn: parent

            color: Frappe.green
            transform: [
                Rotation {
                    origin.x: secondHand.width / 2
                    origin.y: secondHand.height
                    angle: root.second * 6
                },
                Translate {
                    y: -secondHand.height / 2
                }
            ]
        }
        Rectangle { // hour
            id: hourHand
            width: 6
            height: root.width / 5
            radius: 3
            anchors.centerIn: parent

            color: Frappe.text
            transform: [
                Rotation {
                    origin.x: hourHand.width / 2
                    origin.y: hourHand.height
                    angle: (root.hour + root.minute / 60) * 30
                },
                Translate {
                    y: -hourHand.height / 2
                }
            ]
        }
        Rectangle { // minute
            id: minuteHand
            width: 4
            height: root.width / 3
            radius: 3
            anchors.centerIn: parent

            color: Frappe.text
            transform: [
                Rotation {
                    origin.x: minuteHand.width / 2
                    origin.y: minuteHand.height
                    angle: root.minute * 6
                },
                Translate {
                    y: -minuteHand.height / 2
                }
            ]
        }

        Rectangle {
            width: 10
            height: 10
            radius: 5
            anchors.centerIn: parent
            color: Frappe.text
            Rectangle {
                width: 6
                height: 6
                radius: 3
                anchors.centerIn: parent
                color: Frappe.green
            }
        }

        Repeater {
            model: [0, 3, 6, 9]
            delegate: Rectangle {
                id: tick
                width: 3
                height: 15
                radius: 2
                color: Frappe.text
                anchors.centerIn: parent
                property real angle: modelData * 30
                property real radAngle: angle * (Math.PI / 180)

                transform: [
                    Rotation {
                        origin.x: tick.width / 2
                        origin.y: tick.height
                        angle: modelData * 30 - 90
                    },
                    Translate {
                        x: (root.width / 2 - 10) * Math.cos(tick.radAngle) - tick.width / 2
                        y: (root.height / 2 - 10) * Math.sin(tick.radAngle) - tick.height / 2
                    }
                ]
            }
        }

        Repeater {
            model: [1, 2, 4, 5, 7, 8, 10, 11]
            delegate: Rectangle {
                id: tick2
                width: 2
                height: 5
                radius: 1
                color: Frappe.surface2
                anchors.centerIn: parent
                property real angle: modelData * 30
                property real radAngle: angle * (Math.PI / 180)

                transform: [
                    Rotation {
                        origin.x: tick2.width / 2
                        origin.y: tick2.height
                        angle: modelData * 30 - 90
                    },
                    Translate {
                        x: (root.width / 2 - 10) * Math.cos(tick2.radAngle) - tick2.width / 2
                        y: (root.height / 2 - 10) * Math.sin(tick2.radAngle) - tick2.height / 2
                    }
                ]
            }
        }

    }
}
