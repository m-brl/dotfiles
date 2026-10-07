import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Wayland

import "../constants"
import "../components"
import "../services"
import "../utils.js" as Utils

PopupWindow {
    id: root

    required property string text

    width: 100
    height: 60
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 10
        radius: 5
        color: Theme.base0
    }

    Item {
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        Text {
            anchors.centerIn: parent
            font.pixelSize: 14
            font.family: Theme.fontFamily
            color: Theme.text
            text: root.text
        }
    }
}
