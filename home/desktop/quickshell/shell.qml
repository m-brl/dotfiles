import QtQuick
import Quickshell

ShellRoot {
    id: rootShell

    Loader {
        source: "components/capslock-osd.qml"
        active: true
    }
    Loader {
        source: "components/brightness-osd.qml"
        active: true
    }
    Loader {
        source: "components/volume-osd.qml"
        active: true
    }
}
