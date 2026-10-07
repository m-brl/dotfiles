import QtQuick

import "../constants"

Rectangle {
    id: root

    implicitWidth: 32
    implicitHeight: 32
    radius: 5

    property string value: ""
    property color backgroundColor: Theme.primary
    property color hoverColor: Qt.darker(root.backgroundColor, 1.2)
    property alias iconColor: text.color
    signal clicked()
    readonly property bool hovered: mouseArea.containsMouse

    color: mouseArea.containsMouse ? root.hoverColor : root.backgroundColor

    Text {
        id: text
        anchors.centerIn: parent

        color: Theme.text
        font.pixelSize: 14
        font.family: "JetBrainsMono Nerd Font"

        text: root.value
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
