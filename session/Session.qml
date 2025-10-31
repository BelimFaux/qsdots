pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs
import qs.widgets

Scope {
    id: root

    LazyLoader {
        id: loader
        active: false

        Variants {
            model: Quickshell.screens

            delegate: PanelWindow {
                id: session
                property var modelData
                screen: modelData

                BlurredBackground {
                    screen: session.screen
                    blurRadius: Config.sessionBlur
                }

                anchors {
                    top: true
                    left: true
                    right: true
                    bottom: true
                }

                exclusionMode: ExclusionMode.Ignore
                WlrLayershell.namespace: "quickshell:session"
                WlrLayershell.layer: WlrLayer.Overlay
                WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        loader.active = false;
                    }
                }

                ColumnLayout {
                    spacing: Config.sessionButtonSpacing
                    anchors.centerIn: parent
                    SessionButton {
                        id: sessionLock
                        title: "Lock"
                        iconChar: "󰌾"
                        focus: true
                        commands: ["sh", "-c", "qs ipc call lockscreen lock"]
                        onClicked: {
                            loader.active = false;
                        }
                        onWantsQuitChanged: {
                            loader.active = false;
                        }
                        next: sessionSleep
                        previous: sessionShutdown
                    }
                    SessionButton {
                        id: sessionSleep
                        title: "Sleep"
                        iconChar: "󰤄"
                        commands: ["sh", "-c", "systemctl suspend || loginctl suspend"]
                        onClicked: {
                            loader.active = false;
                        }
                        onWantsQuitChanged: {
                            loader.active = false;
                        }
                        next: sessionLogOut
                        previous: sessionLock
                    }
                    SessionButton {
                        id: sessionLogOut
                        title: "Log out"
                        iconChar: "󰍃"
                        commands: ["sh", "-c", "pkill Hyprland"]
                        onWantsQuitChanged: {
                            loader.active = false;
                        }
                        next: sessionReboot
                        previous: sessionSleep
                    }
                    SessionButton {
                        id: sessionReboot
                        title: "Reboot"
                        iconChar: "󰑓"
                        commands: ["sh", "-c", "reboot || loginctl reboot"]
                        onWantsQuitChanged: {
                            loader.active = false;
                        }
                        next: sessionShutdown
                        previous: sessionLogOut
                    }
                    SessionButton {
                        id: sessionShutdown
                        title: "Shutdown"
                        iconChar: "󰐥"
                        commands: ["sh", "-c", "systemctl poweroff || loginctl poweroff"]
                        onWantsQuitChanged: {
                            loader.active = false;
                        }
                        next: sessionLock
                        previous: sessionReboot
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "session"

        function toggle(): void {
            loader.active = !loader.active;
        }
    }
}
