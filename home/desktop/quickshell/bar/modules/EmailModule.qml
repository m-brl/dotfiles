import QtQuick
import QtQuick.Layouts

import "../services"
import "../components"

IconButton {
    id: root
    required property EmailService emailService

    value: `󰇮 ${root.emailService.nbEmail ?? 0} 󰖣 ${root.emailService.nbWhatsapp ?? 0}`
}
