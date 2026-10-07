import QtQuick

import Quickshell.Io

Item {
    id: root

    property string dbPath: "~/.cache/cliphist/db"
    property var clipboardHistory: []

    function getFilteredHistory(searchTerm) {
        if (!searchTerm) return root.clipboardHistory;

        let re;
        try {
            re = new RegExp(searchTerm, "i");
        } catch (e) {
            return [];
        }
        return root.clipboardHistory.filter(item => re.test(item.content));
    }

    Process {
        id: proc
    }

    Process {
        id: fetchClipboardProcess
        command: ["sh", "-c", `cliphist list` ]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const raw = text.trim();
                    if (!raw) {
                        root.clipboardHistory = [];
                        return;
                    }

                    const data = raw
                        .split("\n")
                        .filter(item => item.length > 0)
                        .map(item => {
                            const tab = item.indexOf("\t")
                            return {
                                id: item.substring(0, tab),
                                content: item.substring(tab + 1)
                            }
                        })
                    root.clipboardHistory = data;
                } catch (e) {
                    console.error("Error parsing clipboard history:", e);
                }
            }
        }
    }

    Timer {
        id: fetchClipboardTimer
        interval: 1000
        repeat: true
        onTriggered: {
            root.fetchClipboardHistory()
        }
    }

    function fetchClipboardHistory() {
        fetchClipboardProcess.running = true;
    }

    Process {
        id: copyProcess
        property int itemId: -1

        command: ["sh", "-c", `cliphist decode ${copyProcess.itemId} | wl-copy`]
    }

    function copyToClipboard(item) {
        copyProcess.itemId = item.id;
        copyProcess.running = true;
    }


    Process {
        id: dumpProcess
        property int itemId: -1

        command: ["sh", "-c", `cliphist decode ${dumpProcess.itemId} > /tmp/cliphist_dump_${dumpProcess.itemId}.txt`]
    }

    function dumpToFile(item) {
        dumpProcess.itemId = item.id;
        dumpProcess.running = true;
    }

    Process {
        id: clearHistory
        command: ["sh", "-c", `cliphist wipe`]
    }

    function clearClipboardHistory() {
        clearHistory.running = true;
    }
}
