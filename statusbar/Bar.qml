import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "components"
import qs

Scope {
    IpcHandler {
        target: "statusbar"

        function toggle(): void {
            loader.active = !loader.active;
        }
    }

    LazyLoader {
        id: loader
        active: true

        Variants {
            model: Quickshell.screens

            delegate: PanelWindow {
                id: bar
                property var modelData
                screen: modelData
                color: Theme.barBackground
                implicitHeight: content.implicitHeight + 2

                anchors {
                    top: Theme.topBar
                    bottom: !Theme.topBar
                    left: true
                    right: true
                }

                Rectangle {
                    id: content
                    anchors.fill: parent
                    color: "transparent"
                    implicitHeight: Theme.barHeight
                    anchors.topMargin: 4
                    anchors.bottomMargin: 2

                    RowLayout {
                        id: blocks
                        spacing: 0
                        anchors.fill: parent

                        RowLayout {
                            id: left
                            spacing: Theme.componentMargins
                            Layout.alignment: Qt.AlignLeft
                            Layout.fillWidth: true

                            Icon {
                                Layout.leftMargin: Theme.componentMargins
                            }
                            Workspaces {}
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        RowLayout {
                            Runner {}
                            Window {}
                            WindowControls {}
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        RowLayout {
                            id: right
                            spacing: Theme.componentMargins
                            Layout.alignment: Qt.AlignRight
                            Layout.fillWidth: true

                            SystemTrayComponent {}
                            CpuComponent {}
                            MemoryComponent {}
                            Clock {
                                Layout.rightMargin: bat.visible ? 0 : Theme.componentMargins
                            }
                            Battery {
                                id: bat
                                Layout.rightMargin: Theme.componentMargins
                            }
                        }
                    }
                }
            }
        }
    }
}
