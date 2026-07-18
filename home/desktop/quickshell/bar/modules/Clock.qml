import QtQuick
import QtQuick.Layouts

import Quickshell

import "../constants"

Item {
    id: root

    property string temperature;
    property string weather;

    function getWeatherIcon(code) {
        const basePath = "file:///home/mathieu/quickshell/bar/assets/weather/";
        console.log(">" + code)
        code = parseInt(code)
        switch (code) {
            case 0:
                return basePath + "sun.png";

            case 1:
            case 2:
                return basePath + "sun_cloud.png";
                
            // Couvert / Nuageux
            case 3:
                return basePath + "cloud.png";
                
            // Brouillard et givre
            case 45:
            case 48:
                return basePath + "cloud.png"; // Faute d'icône brouillard
                
            // Bruine (Légère, modérée, dense)
            case 51:
            case 53:
            case 55:
            case 56: // Bruine verglaçante
            case 57:
                return basePath + "rain.png";
                
            // Pluie (Faible, modérée, forte)
            case 61:
            case 63:
            case 65:
            case 66: // Pluie verglaçante
            case 67:
            case 80: // Averses de pluie faibles
            case 81: // Averses de pluie modérées
            case 82: // Averses de pluie violentes
                return basePath + "rain.png";
                
            // Neige (Faible, modérée, forte, grains)
            case 71:
            case 73:
            case 75:
            case 77:
            case 85: // Averses de neige faibles
            case 86: // Averses de neige fortes
                return basePath + "snow.png";
                
            // Orage (Faible, modéré, avec grêle)
            case 95:
            case 96:
            case 99:
                return basePath + "cloud_thunder.png";
        }
        return "file:///home/mathieu/quickshell/bar/assets/weather/sun.png"
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

                        source: root.getWeatherIcon(root.weather)
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
                                root.fetchWeather()
                            }
                        }
                    }
                }
            }

        }
    }
}
