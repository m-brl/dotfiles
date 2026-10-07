import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import "../constants"

Item {
    id: root
    implicitWidth: wsListView.width

    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: wsListView.contentWidth

        ListView {
            id: wsListView
            anchors.fill: parent
            orientation: ListView.Horizontal
            spacing: 0
            leftMargin: 10

            model: Hyprland.workspaces
            delegate: Rectangle {
                implicitWidth: 30
                implicitHeight: 30
                radius: 5
                anchors.verticalCenter: parent.verticalCenter

                property int wsId: modelData.id
                property int isFocused: modelData.focused
                color: isFocused ? Theme.primary : "transparent"

                Text {
                    anchors.centerIn: parent

                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    font.bold: true

                    color: Theme.text
                    text: wsId
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        modelData.activate()
                    }
                }
            }
        }
    }
}
