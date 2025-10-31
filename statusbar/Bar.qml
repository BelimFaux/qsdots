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
                color: Config.barBackground
                implicitHeight: content.implicitHeight + 2

                anchors {
                    top: Config.topBar
                    bottom: !Config.topBar
                    left: true
                    right: true
                }

                Rectangle {
                    id: content
                    anchors.fill: parent
                    color: "transparent"
                    implicitHeight: Config.barHeight
                    anchors.topMargin: 4
                    anchors.bottomMargin: 2

                    RowLayout {
                        id: blocks
                        spacing: 0
                        anchors.fill: parent

                        RowLayout {
                            id: left
                            spacing: Config.componentMargins
                            Layout.alignment: Qt.AlignLeft
                            Layout.fillWidth: true

                            Icon {
                                Layout.leftMargin: Config.componentMargins
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
                            spacing: Config.componentMargins
                            Layout.alignment: Qt.AlignRight
                            Layout.fillWidth: true

                            SystemTrayComponent {}
                            CpuComponent {}
                            MemoryComponent {}
                            Clock {
                                Layout.rightMargin: bat.visible ? 0 : Config.componentMargins
                            }
                            Battery {
                                id: bat
                                Layout.rightMargin: Config.componentMargins
                            }
                        }
                    }
                }
            }
        }
    }
}
