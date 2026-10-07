import QtQuick
import QtQuick.Layouts

import "../constants"
import "../services"
import "../components"

Item {
    id: root
    required property EmailService emailService

    IconButton {
        id: button
        anchors.fill: parent

        value: `󰇮 ${root.emailService.nbEmail ?? 0}`
        iconColor: Theme.text
        backgroundColor: Theme.primary
    }
}
