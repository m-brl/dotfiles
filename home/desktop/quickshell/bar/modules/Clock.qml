import QtQuick
import QtQuick.Layouts

import Quickshell

import "../constants"

Item {
    id: root

    property string temperature;
    property string weather;

    function getWeatherIcon(code) {
        switch (code) {
            case 0:
                return "󰖙"
        }
        return "󰖙"
    }

    function fetchWeather() {
        let url = `https://api.open-meteo.com/v1/forecast?latitude=45.7640&longitude=4.8357&current=temperature_2m,weather_code&timezone=auto`

        let xhr = new XMLHttpRequest()
        xhr.open("GET", url)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    try {
                        let response = JSON.parse(xhr.responseText)
                        let current = response.current
                    
                        root.temperature = Math.round(current.temperature_2m) + "°C"
                        root.weather = current.weather_code
                        root.weather = 1
                    
                        //updateWeather(current.weather_code)
                    } catch (e) {
                    }
                } else {
                }
            }
        }
        xhr.send()
    }

    Timer {
        interval: 300 * 1000
        running: true
        repeat: true
        onTriggered: root.fetchWeather()
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        RowLayout {
            anchors.fill: parent

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "transparent"
                    Text {
                        anchors.left: parent.left
                        anchors.top: parent.top

                        font.pixelSize: 18
                        font.family: "JetBrainsMono Nerd Font"
                        font.bold: true

                        color: Macchiato.blue
                        text: String(clockService.hours).padStart(2, "0") + ":" + 
                            String(clockService.minutes).padStart(2, "0") + ":" +
                            String(clockService.seconds).padStart(2, "0") + " " + clockService.amPm
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "transparent"
                    Text {
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom

                        color: Macchiato.text
                        font.pixelSize: 14
                        font.family: "JetBrainsMono Nerd Font"
                        text: clockService.dayOfWeek + ", " + 
                            clockService.monthName + " " + clockService.day
                    }
                }
            }

            Rectangle { // weather
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                RowLayout {
                    anchors.fill: parent

                    Item {
                        Layout.fillWidth: true
                    }

                    Image {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40

                        source: "file:///home/mathieu/quickshell/bar/assets/weather/sun.png"
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: Layout.preferredWidth
                        sourceSize.height: Layout.preferredHeight
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        color: "transparent"
                        Layout.fillWidth: true
                        Text {
                            anchors.centerIn: parent
                            color: Macchiato.sapphire
                            font.pixelSize: 18
                            font.bold: true
                            font.family: "JetBrainsMono Nerd Font"

                            text: root.temperature + ""

                            Component.onCompleted: {
                                //root.fetchWeather()
                            }
                        }
                    }
                }
            }

        }
    }
}
