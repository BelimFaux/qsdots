pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    id: root
    property int maxBrightness
    property int currentBrightness
    property bool brightnessChanged

    function brightnessPercent(): real {
        return root.currentBrightness / root.maxBrightness;
    }

    Process {
        id: getMax
        running: true
        command: ["brightnessctl", "max"]
        stdout: StdioCollector {
            onStreamFinished: root.maxBrightness = text
        }
    }

    Process {
        id: getCurrent
        running: true
        command: ["brightnessctl", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (root.currentBrightness != text) {
                    root.currentBrightness = text;
                    root.brightnessChanged = true;
                    changeTimer.restart();
                }
            }
        }
    }

    Timer {
        id: changeTimer
        interval: 1000
        onTriggered: root.brightnessChanged = false
    }

    Timer {
        running: true
        repeat: true
        interval: 100
        onTriggered: getCurrent.running = true
    }
}
