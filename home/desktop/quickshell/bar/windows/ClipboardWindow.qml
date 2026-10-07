import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower

import "../constants"
import "../services"
import "../utils.js" as Utils

PanelWindow {
    id: root

    GlobalShortcut {
        name: "clipboardToggle"
        description: "Open history"
        onPressed: root.toggle()
    }

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    required property ClipboardService clipboardService

    visible: false
    color: "transparent"
    width: 600
    height: 500

    enum Mode {
        Command,
        Insert
    }
    property int mode: ClipboardWindow.Mode.Insert

    Process {
        id: appEditor
        property int itemId

        command: ["sh", "-c", `cliphist decode ${appEditor.itemId} > /tmp/cliphist_dump_${appEditor.itemId}.txt && xdg-open /tmp/cliphist_dump_${appEditor.itemId}.txt`]
    }

    function toggle() {
        searchInput.text = ""
        searchInput.forceActiveFocus()
        clipboardService.fetchClipboardHistory()
        root.mode = ClipboardWindow.Mode.Insert
        root.visible = !root.visible
    }

    function copyCurrent() {
        const currentItem = clipboardListView.currentItem
        if (currentItem) {
            root.clipboardService.copyToClipboard(currentItem.modelData)
            root.toggle()
        }
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: background
            anchors.fill: parent
            radius: 5
            color: Theme.base0
        }

        Rectangle {
            id: searchBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40
            radius: 5

            color: Theme.base1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12

                TextInput {
                    id: searchInput
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    verticalAlignment: TextInput.AlignVCenter

                    font.pixelSize: 14
                    font.family: Theme.fontFamily

                    color: Theme.text

                    Keys.onPressed: event => {
                        if (root.mode === ClipboardWindow.Mode.Insert) {
                            switch (event.key) {
                                case Qt.Key_Escape: root.mode = ClipboardWindow.Mode.Command; break;
                                case Qt.Key_Up: clipboardListView.decrementCurrentIndex(); break;
                                case Qt.Key_Down: clipboardListView.incrementCurrentIndex(); break;
                                case Qt.Key_Return: root.copyCurrent(); break;
                            }
                            return
                        }

                        if (root.mode === ClipboardWindow.Mode.Command) {
                            event.accepted = true
                            switch (event.key) {
                                case Qt.Key_I: root.mode = ClipboardWindow.Mode.Insert; break;
                                case Qt.Key_Escape: root.toggle(); break;
                                case Qt.Key_Up: clipboardListView.decrementCurrentIndex(); break;
                                case Qt.Key_Down: clipboardListView.incrementCurrentIndex(); break;
                                case Qt.Key_Return: root.copyCurrent(); break;
                                case Qt.Key_E: {
                                    appEditor.itemId = clipboardListView.currentItem.modelData.id
                                    appEditor.running = true
                                    root.toggle()
                                }
                            }

                        }
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 40

                    color: clearButton.containsMouse ? Theme.base3 : Theme.base1
                    radius: 5

                    Text {
                        anchors.centerIn: parent
                        color: Theme.red
                        font.pixelSize: 18
                        text: "󰩹"
                    }

                    MouseArea {
                        id: clearButton
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            root.clipboardService.clearClipboardHistory()
                            root.clipboardService.fetchClipboardHistory()
                        }
                    }
                }
            }
        }

        ListView {
            id: clipboardListView

            anchors.top: searchBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            model: root.clipboardService.getFilteredHistory(searchInput.text)

            delegate: Rectangle {
                required property var modelData
                required property int index

                width: parent.width
                height: 30
                radius: 5
                color: index == clipboardListView.currentIndex ? Theme.primary1 : "transparent"

                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight

                    color: Theme.text
                    font.pixelSize: 14
                    font.family: Theme.fontFamily
                    text: modelData.content
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: clipboardListView.currentIndex = index
                    onClicked: root.copyCurrent()
                }
            }
        }
    }
}
