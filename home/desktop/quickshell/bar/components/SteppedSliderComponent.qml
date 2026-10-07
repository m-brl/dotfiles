import QtQuick
import QtQuick.Controls

import "../constants"
import "../components"
import "../services"
import "../utils.js" as Utils

Slider {
    id: root

    property int steps: 0
    property color trackColor: Theme.base3

    from: 0
    to: steps - 1
    stepSize: 1
    snapMode: Slider.SnapAlways

    implicitWidth: 100
    implicitHeight: 20

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + (root.availableHeight / 2 - height / 2)
        width: root.availableWidth
        height: 6
        radius: 3
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: Theme.primary }
            GradientStop { position: 0.6; color: Theme.yellow }
            GradientStop { position: 1.0; color: Theme.red }
        }

        Rectangle {
            x: root.handle.x + root.handle.width / 2
            width: parent.width - x + 1
            height: parent.height
            radius: 3
            color: Theme.base1
        }
    }

    handle: Rectangle {
        id: handle

        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2

        width: 20
        height: width
        radius: width / 4
        color: Theme.primary
        scale: root.pressed ? 1.2 : 1
        Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        Behavior on width { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }
    }
}
