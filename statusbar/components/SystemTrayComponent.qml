import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import qs
import qs.widgets

Rectangle {
    id: root

    Layout.preferredWidth: elems.implicitWidth + Config.componentPadding
    Layout.preferredHeight: Config.componentHeight
    radius: Config.componentHeight / 3
    color: Config.componentBackground
    border.color: Config.systemTrayBorder
    border.width: Config.componentBorderSize

    Item {
        id: contentContainer
        implicitWidth: root.elems.implicitWidth
        implicitHeight: root.elems.implicitHeight
        anchors.centerIn: parent
        children: root.elems
    }

    property var elems: RowLayout {
        anchors.centerIn: parent
        Repeater {
            model: SystemTray.items.values

            Rectangle {
                id: component
                required property SystemTrayItem modelData
                property alias item: component.modelData
                Layout.preferredWidth: Config.iconHeight + 2
                Layout.preferredHeight: Config.componentHeight
                color: "transparent"

                IconImage {
                    anchors.centerIn: parent
                    implicitSize: Config.iconHeight
                    source: component.item.icon
                }

                QsMenuAnchor {
                    id: menuAnchor
                    menu: component.item.menu

                    anchor.window: component.QsWindow.window

                    anchor.onAnchoring: {
                        const window = component.QsWindow.window;
                        const widgetRect = window.contentItem.mapFromItem(component, 0, component.height, component.width, component.height);

                        menuAnchor.anchor.rect = widgetRect;
                    }
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: component
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    onClicked: function (mouse) {
                        if (component.item.onlyMenu || mouse.button === Qt.RightButton)
                            menuAnchor.open();
                        else if (mouse.button === Qt.LeftButton)
                            component.item.activate();
                        else
                            component.item.secondaryActivate();
                    }
                    onHoveredChanged: {
                        if (component.modelData.tooltipTitle != "")
                            tooltip.visible = !tooltip.visible;
                    }
                }

                TooltipWindow {
                    id: tooltip
                    anchorItem: component
                    visible: false
                    borderColor: Config.systemTrayBorder
                    content: Text {
                        text: qsTr(component.modelData.tooltipTitle)
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
