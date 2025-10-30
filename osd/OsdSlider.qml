pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs

Scope {
    id: root
    required property bool active
    required property string text
    required property var value
    required property var borderColor

    LazyLoader {
        active: root.active

        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            aboveWindows: WlrLayer.Overlay

            implicitWidth: Theme.osdSliderWidth
            implicitHeight: Theme.osdSliderHeight
            color: "transparent"

            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: Theme.osdSliderHeight / 3
                color: Theme.osdSliderBackground
                border.color: root.borderColor
                border.width: Theme.osdSliderBorderSize

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: Theme.osdSliderMargin
                        rightMargin: Theme.osdSliderMargin
                    }

                    Text {
                        text: qsTr(root.text)
                        font.pixelSize: Theme.osdSliderIconSize
                        font.family: Theme.iconFontFamily
                        color: Theme.osdSliderFilled
                    }

                    Rectangle {
                        Layout.fillWidth: true

                        implicitHeight: Theme.osdSliderBarHeight
                        radius: Theme.osdSliderBarHeight / 2
                        color: Theme.osdSliderUnfilled

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                            implicitWidth: parent.width * root.value
                            radius: parent.radius
                            color: Theme.osdSliderFilled
                        }
                    }
                }
            }
        }
    }
}
