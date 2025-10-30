pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real freeMem
    property real usedMem

    Process {
        id: memProc
        command: ["sh", "-c", "free -m | grep Mem | awk '{printf \"%s\\n%s\", $3, $2}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const [free, used] = text.split("\n");
                root.freeMem = free;
                root.usedMem = used;
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 500
        onTriggered: memProc.running = true
    }
}
