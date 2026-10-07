import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import "../constants"
import "../services"
import "../utils.js" as Utils

Item {
    id: root

    property string title: ""
    property string subtitle: ""
    property string content: ""

    property color strokeColor: Theme.primary
    property var value: 0

    Shape {
        id: ring
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4

        ShapePath {
            strokeColor: Theme.base3
            strokeWidth: 10
            fillColor: "transparent"

            PathAngleArc {
                centerX: ring.width / 2
                centerY: ring.height / 2
                radiusX: 110
                radiusY: 110
                startAngle: -90
                sweepAngle: 360
            }
        }

        ShapePath {
            strokeColor: Theme.primary
            strokeWidth: 10
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: ring.width / 2
                centerY: ring.height / 2
                radiusX: 110
                radiusY: 110
                startAngle: -90
                sweepAngle: root.value * 360
            }
        }
    }

    Column {
        anchors.centerIn: parent

        Text {
            id: titleText
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.title !== ""

            text: root.title
            font.pixelSize: 48
            font.bold: true
            font.family: Theme.fontFamily
            color: Theme.text
        }
        Text {
            id: subtitleText
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.subtitle !== ""

            text: root.subtitle
            font.pixelSize: 18
            font.family: Theme.fontFamily
            color: Theme.text
        }
        Text {
            id: contentText
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.content !== ""

            text: root.content
            font.pixelSize: 13
            font.family: Theme.fontFamily
            color: Theme.text
            opacity: 0.7
        }
    }
}
