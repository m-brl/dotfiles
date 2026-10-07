import QtQuick

import Quickshell.Io

Item {
    id: root

    property int nbEmail: 0

    Process {
        id: mailProcess
        command: ["notmuch", "count", "tag:unread"]

        stdout: SplitParser {
            onRead: data => {
                root.nbEmail = parseInt(data.trim(), 10) || 0
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            mailProcess.running = true;
        }
    }
}
