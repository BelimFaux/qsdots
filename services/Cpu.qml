pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string temp
    property string fanSpeed

    Process {
        id: cpuProc
        command: ["sh", "-c", "sensors | grep -ie 'cpu' -e 'fan'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const [name, val] = data.split(":");
                if (name.includes("CPU")) {
                    root.temp = val.trim();
                } else if (name.includes("fan")) {
                    root.fanSpeed = val.trim();
                }
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 500
        onTriggered: cpuProc.running = true
    }
}
