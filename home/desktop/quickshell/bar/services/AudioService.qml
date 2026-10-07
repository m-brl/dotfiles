import QtQuick

import Quickshell.Io

Item {
    id: root

    property bool isMicInUse: false
    property real volume: 0
    property bool muted: false
    property var activeSourceOutputs: []
    property var activeSinkInputs: []

    Process {
        command: ["pactl", "subscribe"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                if (line.includes("'change' on sink #")) {
                    fetchVolumeProcess.running = true;
                }
            }
        }
    }

    Process {
        id: fetchVolumeProcess
        command: ["sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@; pactl get-sink-mute @DEFAULT_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
                const volumeMatch = text.match(/Volume:.*?(\d+)%/);
                const muteMatch = text.match(/Mute:\s*(yes|no)/);

                if (volumeMatch && muteMatch) {
                    root.volume = parseInt(volumeMatch[1]) / 100;
                    root.muted = muteMatch[1] === "yes";
                }
            }
        }
    }

    Process {
        id: fetchSourceOutputsProcess
        command: ["pactl", "--format=json", "list", "source-outputs"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const raw = text.trim();
                    if (!raw) {
                        root.isMicInUse = false;
                        root.activeSourceOutputs = [];
                        return;
                    }

                    const data = JSON.parse(text.trim());
                    const activeStreams = data.filter(item => !item.corked);

                    root.isMicInUse = activeStreams.length > 0;

                    root.activeSourceOutputs = activeStreams.map(item => ({
                        index: item.index,
                        name: item.properties && item.properties["application.name"] || "Unknown",
                        mute: item.mute,
                    }))
                } catch (e) {
                    root.isMicInUse = false;
                }
            }
        }
    }


    Process {
        id: fetchSinkInputsProcess
        command: ["pactl", "--format=json", "list", "sink-inputs"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const raw = text.trim();
                    if (!raw) {
                        root.activeSinkInputs = [];
                        return;
                    }

                    const data = JSON.parse(text.trim());
                    const activeStreams = data.filter(item => !item.corked);


                    root.activeSinkInputs = activeStreams.map(item => ({
                        index: item.index,
                        name: item.properties && item.properties["application.name"] || "Unknown",
                        mute: item.mute,
                    }))
                } catch (e) {
                    root.isMicInUse = false;
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            fetchSourceOutputsProcess.running = true;
            fetchSinkInputsProcess.running = true;
        }
    }

    Process {
        id: proc

        onExited: {
            fetchSourceOutputsProcess.running = true;
            fetchSinkInputsProcess.running = true;
        }
    }

    function toggleSourceMute(index) {
        proc.command = ["pactl", "set-source-output-mute", index, "toggle"];
        proc.running = true;
    }

    function toggleSinkMute(index) {
        proc.command = ["pactl", "set-sink-input-mute", index, "toggle"];
        proc.running = true;
    }
}
