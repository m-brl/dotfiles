pragma Singleton

import QtQuick

QtObject {
    readonly property color base00: "#2e3440"
    readonly property color base01: "#3b4252"
    readonly property color base02: "#434c5e"
    readonly property color base03: "#4c566a"
    readonly property color base04: "#d8dee9"
    readonly property color base05: "#e5e9f0"
    readonly property color base06: "#eceff4"
    readonly property color base07: "#8fbcbb"
    readonly property color base08: "#bf616a"
    readonly property color base09: "#d08770"
    readonly property color base0A: "#ebcb8b"
    readonly property color base0B: "#a3be8c"
    readonly property color base0C: "#88c0d0"
    readonly property color base0D: "#81a1c1"
    readonly property color base0E: "#b48ead"
    readonly property color base0F: "#5e81ac"

    readonly property string sansFamily: "IBM Plex Sans"
    readonly property string serifFamily: "IBM Plex Serif"
    readonly property string monoFamily: "JetBrainsMono Nerd Font"

    // alias sémantiques
    readonly property color background: base00

    readonly property color surface: base01
    readonly property color surface1: base01
    readonly property color surface2: base02
    readonly property color surface3: base03

    readonly property color text: base05
    readonly property color accent: base0D

}
