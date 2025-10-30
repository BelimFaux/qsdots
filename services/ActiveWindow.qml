pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    property bool isSpecial: false
    property bool isSome: true
    property bool isFullscreen: false
    property string workspaceName: ""
    property string monitorId: ""
    property string name: ""
    property string windowClass: ""

    function close() {
        Hyprland.dispatch('killactive');
    }

    function fullscreen(full: bool) {
        Hyprland.dispatch('fullscreen ' + (full ? '0' : '1'));
    }

    function moveToWorkspace(workspace: string) {
        Hyprland.dispatch('movetoworkspacesilent ' + workspace);
    }

    Process {
        id: windowWorkspaceProc
        running: true
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.workspace.name,.title,.class,.monitor,.fullscreen'"]
        stdout: StdioCollector {
            onStreamFinished: {
                const [wsname, name, wclass, monitor, fullscreen] = text.split('\n');
                root.isSome = name !== "null";
                root.name = name;
                root.windowClass = wclass;
                root.workspaceName = wsname;
                root.monitorId = monitor;
                root.isSpecial = wsname.includes("special");
                root.isFullscreen = fullscreen === '1';
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 500
        onTriggered: windowWorkspaceProc.running = true
    }
}
