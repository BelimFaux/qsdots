pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import qs
import qs.services
import qs.widgets

Rectangle {
    id: root
    property var model: ScriptModel {
        values: {
            return [...Hyprland.workspaces.values].filter(ws => {
                return !ws.name.includes("special");
            }).sort((a, b) => a.id - b.id);
        }
    }

    Layout.preferredWidth: elems.implicitWidth + Config.componentPadding
    Layout.preferredHeight: Config.componentHeight
    radius: Config.componentHeight / 3
    color: Config.componentBackground
    border.color: Config.workspacesBorder
    border.width: Config.componentBorderSize

    Item {
        id: contentContainer
        implicitWidth: root.elems.implicitWidth
        implicitHeight: root.elems.implicitHeight
        anchors.centerIn: parent
        children: root.elems
    }

    property var elems: RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter

        BarComponent {
            id: special
            Layout.preferredHeight: root.height - 8
            property bool toggled: ActiveWindow.isSpecial

            content: Text {
                text: qsTr("")
                color: Config.textColor
                font.family: Config.textFontFamily
                font.pointSize: Config.fontSize
            }

            bgColor: toggled ? Config.workspaceActive : Config.workspaceInactive
            hoverColor: Config.workspaceHover
            borderColor: "transparent"

            onClicked: function () {
                Hyprland.dispatch("togglespecialworkspace scratchpad");
            }

            onHovered: function () {
                specialTip.visible = !specialTip.visible;
            }

            TooltipWindow {
                id: specialTip
                visible: false
                anchorItem: special
                borderColor: Config.workspacesBorder

                content: Text {
                    text: qsTr((special.toggled ? "close" : "open") + " scratchpad")
                    font.family: Config.textFontFamily
                    font.pixelSize: Config.workspaceWindowTitleFontSize
                    color: Config.textColor
                    padding: 5
                }
            }
        }

        Repeater {
            model: root.model
            BarComponent {
                id: comp
                Layout.preferredHeight: root.height - 8

                required property HyprlandWorkspace modelData
                property HyprlandWorkspace ws: modelData
                property bool isActive: Hyprland.focusedMonitor?.activeWorkspace?.id === ws?.id

                content: Text {
                    text: {
                        const name = comp.ws?.name ?? "?";
                        const prefix = comp.ws?.urgent ?? false;
                        return (prefix ? "!" : "") + name;
                    }
                    color: Config.textColor
                    font.family: Config.textFontFamily
                    font.pointSize: Config.fontSize
                    leftPadding: comp.isActive ? Config.workspaceActivePadding : 0
                    rightPadding: comp.isActive ? Config.workspaceActivePadding : 0

                    Behavior on leftPadding {
                        NumberAnimation {
                            duration: Config.workspacePaddingAnimationDuration
                            easing.type: Easing.InOutQuad
                        }
                    }
                    Behavior on rightPadding {
                        NumberAnimation {
                            duration: Config.workspacePaddingAnimationDuration
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                bgColor: isActive ? Config.workspaceActive : Config.workspaceInactive
                hoverColor: Config.workspaceHover
                borderColor: "transparent"

                onClicked: function () {
                    ws.activate();
                }

                onHovered: function () {
                    if ((comp.ws?.toplevels.values ?? []).length > 0)
                        previewWindow.visible = !previewWindow.visible;
                }

                TooltipWindow {
                    id: previewWindow
                    visible: false
                    anchorItem: comp
                    borderColor: Config.workspacesBorder

                    content: Column {
                        id: windowNames

                        Repeater {
                            model: {
                                const list = comp.ws?.toplevels.values.map(tl => tl.title) ?? [];
                                return list.length > 0 ? list : ["Empty"];
                            }

                            Text {
                                id: text
                                required property string modelData
                                text: modelData
                                font.family: Config.textFontFamily
                                font.pixelSize: Config.workspaceWindowTitleFontSize
                                color: Config.textColor
                                padding: 5
                            }
                        }
                    }
                }
            }
        }
    }
}
