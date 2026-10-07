import QtQuick

Rectangle {
    id: root

    implicitWidth: 32
    implicitHeight: 32
    radius: 15

    property string value: ""
    property alias backgroundColor: root.color
    property alias iconColor: text.color
    signal clicked()

    Text {
        id: text
        anchors.centerIn: parent

        font.pixelSize: 14
        font.family: "JetBrainsMono Nerd Font"

        text: root.value
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
