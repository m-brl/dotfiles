import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./constants"

import "./services"

Rectangle {
    id: container
    color: config.color

    ClockService {
        id: clockService
    }

    Image {
        source: config.background
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        anchors.centerIn: parent
        color: "transparent"

        RowLayout {
            anchors.fill: parent

            Rectangle { // left part
                Layout.fillWidth: true
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
                        color: Macchiato.text
                    }

                    Text {
                        anchors.top: parent.top

                        color: Macchiato.text
                        font.pixelSize: 70
                        font.family: "JetBrainsMono Nerd Font"
                        font.bold: true

                        text: String(clockService.hours).padStart(2, "0") + ":" + 
                            String(clockService.minutes).padStart(2, "0") + ":" +
                            String(clockService.seconds).padStart(2, "0") + " " + clockService.amPm
                    }

                    Text {
                        anchors.bottom: parent.bottom

                        color: Macchiato.text
                        font.pixelSize: 50
                        font.family: "JetBrainsMono Nerd Font"

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

                    width: 300
                    height: 500

                    radius: 15
                    color: Qt.alpha(Macchiato.base, 0.5)

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 30
                        anchors.rightMargin: 30
                        anchors.topMargin: 100
                        anchors.bottomMargin: 100
                        spacing: 10

                        Rectangle { // user
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60
                            color: "transparent"

                            Rectangle { // bottom border
                                height: 2
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right

                                color: Qt.alpha(Macchiato.base, 0.8)
                            }

                            Rectangle { // icon
                                id: userIcon
                                anchors.top: parent.top
                                anchors.left: parent.left
                                height: 60
                                width: 60
                                color: "transparent"

                                Text {
                                    anchors.centerIn: parent

                                    color: Macchiato.text
                                    font.pixelSize: 42
                                    text: ""
                                }
                            }

                            Text { // label
                                anchors.left: userIcon.right
                                anchors.top: parent.top
                                anchors.right: parent.right
                                height: 20

                                color: Macchiato.text
                                font.pixelSize: 14
                                text: "User"
                            }

                            TextField { // input
                                id: username

                                anchors.left: userIcon.right
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                height: 40

                                color: Macchiato.text
                                placeholderText: "User"
                                placeholderTextColor: Qt.alpha(Macchiato.text, 0.2)
                                text: userModel.lastUser
                                font.pixelSize: 18

                                padding: 0
                                background: null
                            }
                        }

                        Rectangle { // password
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60
                            color: "transparent"

                            Rectangle { // bottom border
                                height: 2
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right

                                color: Qt.alpha(Macchiato.base, 0.8)
                            }

                            Rectangle { // icon
                                id: passwordIcon
                                anchors.top: parent.top
                                anchors.left: parent.left
                                height: 60
                                width: 60
                                color: "transparent"

                                Text {
                                    anchors.centerIn: parent

                                    color: Macchiato.text
                                    font.pixelSize: 42
                                    text: "󰌾"
                                }
                            }

                            Text { // label
                                anchors.left: passwordIcon.right
                                anchors.top: parent.top
                                anchors.right: parent.right
                                height: 20

                                color: Macchiato.text
                                font.pixelSize: 14
                                text: "Password"
                            }

                            TextField {
                                id: password

                                anchors.left: passwordIcon.right
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                height: 40

                                color: Macchiato.text
                                placeholderText: "Password"
                                placeholderTextColor: Qt.alpha(Macchiato.text, 0.2)
                                echoMode: TextInput.Password
                                font.pixelSize: 18

                                padding: 0
                                background: null

                                onAccepted: {
                                    sddm.login(username.text, password.text, sessionModel.lastIndex)
                                }
                            }
                        }

                        Rectangle {
                            Layout.preferredHeight: 60
                            Layout.fillWidth: true
                            border.color: Macchiato.rosewater
                            border.width: 2
                            color: "transparent"
                            radius: 15

                            Text {
                                anchors.centerIn: parent
                                color: Macchiato.rosewater
                                font.family: "JetBrainsMono Nerd Font"
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
}
