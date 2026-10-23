import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import "./constants"

import "./services"

Rectangle {
    id: container
    color: Theme.background

    ClockService {
        id: clockService
    }

    Image {
        anchors.fill: parent
        source: "/home/mathieu/Pictures/firewatch.jpg";
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.accent
    }

    RowLayout {
        anchors.fill: parent

        Rectangle { // left part
            Layout.preferredWidth: 1000
            Layout.fillHeight: true
            color: "transparent"

            Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 100
                anchors.verticalCenter: parent.verticalCenter

                width: 600
                height: 150
                color: "transparent"

                Rectangle {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    width: 10
                    color: Theme.base00
                }

                Text {
                    anchors.top: parent.top

                    color: Theme.text
                    font.pixelSize: 70
                    font.family: Theme.sansFamily
                    font.bold: true

                    text: String(clockService.hours).padStart(2, "0") + ":" + 
                    String(clockService.minutes).padStart(2, "0") + ":" +
                    String(clockService.seconds).padStart(2, "0") + " " + clockService.amPm
                }

                Text {
                    anchors.bottom: parent.bottom

                    color: Theme.text
                    font.pixelSize: 50
                    font.family: Theme.sansFamily

                    text: clockService.dayOfWeek + ", " + clockService.monthName + " " + clockService.day;
                }
            }
        }

        Rectangle { // right part
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter

                Item {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40

                    Text {
                        anchors.centerIn: parent
                        text: "󰁍"
                        color: leftButton.containsMouse ? Qt.darker(Theme.text, 1.5) : Theme.text
                        font.pixelSize: 32
                        font.family: Theme.monoFamily
                    }
                    MouseArea {
                        id: leftButton
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: userList.incrementCurrentIndex()
                    }
                }

                Item {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: 40

                    Text {
                        anchors.centerIn: parent
                        text: "󰁔"
                        color: rightButton.containsMouse ? Qt.darker(Theme.text, 1.5) : Theme.text
                        font.pixelSize: 32
                        font.family: Theme.monoFamily
                    }
                    MouseArea {
                        id: rightButton
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: userList.incrementCurrentIndex()
                    }
                }

                width: 300
                height: 500

                radius: 5
                color: Theme.surface

                ColumnLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    anchors.topMargin: 40
                    anchors.bottomMargin: 40
                    spacing: 10

                    ListView {
                        id: userList
                        model: userModel
                        orientation: ListView.Horizontal
                        currentIndex: userModel.lastIndex

                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 300
                        Layout.alignment: Qt.AlignHCenter

                        delegate: Rectangle {
                            id: user
                            required property string name
                            required property string icon
                            width: 200
                            height: 300
                            radius: 5
                            color: Theme.surface2

                            Column {
                                anchors.centerIn: parent
                                spacing: 10
                                width: parent.width - 40

                                Rectangle {
                                    id: avatarContainer
                                    width: 150
                                    height: 150
                                    radius: 10
                                    color: Theme.base00

                                    anchors.horizontalCenter: parent.horizontalCenter
                                    border.color: Theme.accent
                                    border.width: 2

                                    Image {
                                        id: avatar
                                        anchors.fill: parent
                                        anchors.margins: 2
                                        source: user.icon
                                        fillMode: Image.PreserveAspectCrop
                                        visible: false
                                        mipmap: true
                                        asynchronous: true
                                        sourceSize: Qt.size(width * 5, height * 5)
                                        layer.enabled: true
                                    }

                                    Rectangle {
                                        id: mask
                                        radius: 8
                                        anchors.fill: avatar
                                        visible: false
                                        antialiasing: true
                                        layer.enabled: true
                                        layer.smooth: true
                                        layer.textureSize: Qt.size(width * 5, height * 5)
                                    }

                                    MultiEffect {
                                        anchors.fill: avatar
                                        source: avatar
                                        maskEnabled: true
                                        maskSource: mask
                                    }

                                    Rectangle {
                                        width: 150
                                        height: 150
                                        radius: 10
                                        color: "transparent"
                                        border.color: Theme.accent
                                        border.width: 2
                                    }
                                }

                                Text {
                                    text: user.name
                                    font.family: Theme.sansFamily
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: Theme.text
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                }

                                TextField {
                                    id: userInput

                                    width: parent.width - 40

                                    anchors.horizontalCenter: parent.horizontalCenter

                                    color: Theme.text
                                    placeholderText: "User"
                                    placeholderTextColor: Qt.alpha(Theme.text, 0.2)
                                    echoMode: TextInput.Normal
                                    font.pixelSize: 32

                                    padding: 0
                                    background: null
                                }

                                TextField {
                                    id: password

                                    height: 40
                                    width: parent.width - 40

                                    anchors.horizontalCenter: parent.horizontalCenter

                                    color: Theme.text
                                    placeholderText: "Password"
                                    placeholderTextColor: Qt.alpha(Theme.text, 0.2)
                                    echoMode: TextInput.Password
                                    font.pixelSize: 16

                                    padding: 0
                                    background: null

                                    onAccepted: {
                                        sddm.login(username.text, password.text, sessionModel.lastIndex)
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 200
                        Layout.alignment: Qt.AlignHCenter

                        border.color: Theme.accent
                        border.width: 2
                        color: "transparent"
                        radius: 5

                        Text {
                            anchors.centerIn: parent
                            color: Theme.accent
                            font.family: Theme.sansFamily
                            font.pixelSize: 14
                            font.bold: true
                            text: "Connect"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: sddm.login(username.text, password.text, sessionModel.lastIndex)
                        }
                    }
                }
            }
        }
    }
}
