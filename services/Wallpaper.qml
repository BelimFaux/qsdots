pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string currentImagePath: ""

    Process {
        id: swwwProc
        command: ["sh", "-c", "swww query | awk '{print $9}'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.currentImagePath = data.trim();
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 500
        onTriggered: swwwProc.running = true
    }
}
