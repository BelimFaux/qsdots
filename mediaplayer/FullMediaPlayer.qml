pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: content.height

    property int selectedPlayer: 0
    property MprisPlayer player: Mpris.players.values[selectedPlayer] || null

    Component.onCompleted: {
        const firstPlaying = Mpris.players.values.findIndex(p => p.playbackState == MprisPlaybackState.Playing);
        root.selectedPlayer = firstPlaying !== -1 ? firstPlaying : 0;
    }

    ColumnLayout {
        id: content
        anchors.centerIn: root
        spacing: 5

        Image {
            id: image
            Layout.alignment: Qt.AlignCenter
            source: (root.player?.trackArtUrl ?? "") || Qt.url("res/placeholder.png")
            sourceSize.height: root.width / 2
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: {
                    if (root.player?.canRaise ?? false)
                        root.player.raise();
                }
            }
        }

        MediaInfo {
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: root.width
            player: root.player
        }

        MediaControls {
            player: root.player
        }

        // Actively monitor the play position
        FrameAnimation {
            running: (root.player?.playbackState ?? MprisPlaybackState.Stopped) == MprisPlaybackState.Playing
            onTriggered: root.player.positionChanged()
        }

        Rectangle {
            id: bar
            Layout.topMargin: 10
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.width * (4 / 5)

            implicitHeight: Config.mediaPlayerBarSize
            radius: height / 2
            color: Config.mediaPlayerBarUnfilled

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: function (ev) {
                    if ((root.player?.canSeek ?? false) && (root.player?.positionSupported ?? false))
                        root.player.position = root.player.length * (ev.x / bar.width);
                }
            }

            Rectangle {
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }

                visible: width >= radius

                implicitWidth: parent.width * Math.min((root.player?.position ?? 0) / (root.player?.length ?? 1), 1.0)
                radius: parent.radius
                color: ((root.player?.positionSupported ?? false) && (root.player?.lengthSupported ?? false)) ? Config.mediaPlayerBarFilled : parent.color
            }
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            text: qsTr(((root.player?.positionSupported ?? false) ? formatTime(root.player?.position ?? 0) : "-") + "/" + ((root.player?.lengthSupported ?? false) ? formatTime(root.player?.length ?? 0) : "-"))
            font.family: Config.textFontFamily
            font.pointSize: Config.fontSize
            color: Config.textColor

            function formatTime(time: int): string {
                if (time === 0)
                    return "";
                const seconds = time % 60;
                const minutes = Math.floor(time / 60) % 60;
                const hours = Math.floor(time / (60 * 60));

                return `${hours !== 0 ? hours + ":" : ""}${minutes.toString().padStart(hours !== 0 ? 2 : 1, '0')}:${seconds.toString().padStart(2, '0')}`;
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeft
            Layout.topMargin: 10

            Text {
                text: qsTr("Player:")
                font.family: Config.textFontFamily
                font.pointSize: Config.mediaPlayerSmallFontSize
                color: Config.textColor
            }

            ComboBox {
                id: control
                model: Mpris.players.values.map(p => p.identity)
                currentIndex: root.selectedPlayer

                onActivated: function (i) {
                    root.selectedPlayer = i;
                }

                contentItem: Text {
                    padding: 5
                    rightPadding: control.indicator.width + 5

                    text: control.displayText
                    font.family: Config.textFontFamily
                    font.pointSize: Config.mediaPlayerSmallFontSize
                    color: Config.textColor
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    border.color: Config.mediaPlayerSelectorBorder
                    border.width: 2
                    color: Config.mediaPlayerSelectorBackground
                    radius: 5
                }

                delegate: ItemDelegate {
                    id: delegate
                    required property string modelData
                    required property int index
                    contentItem: Text {
                        text: delegate.modelData
                        font.family: Config.textFontFamily
                        font.pointSize: Config.mediaPlayerSmallFontSize
                        color: Config.textColor
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        implicitWidth: control.width
                        implicitHeight: parent.height
                        color: delegate.highlighted ? Config.mediaPlayerSelectorSelected : "transparent"
                    }
                    highlighted: control.highlightedIndex === index
                }

                popup: Popup {
                    y: control.height + 1
                    width: control.width
                    height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
                    padding: 1

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: control.popup.visible ? control.delegateModel : null
                        currentIndex: control.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator {}
                    }

                    background: Rectangle {
                        border.color: Config.mediaPlayerSelectorBorder
                        border.width: 2
                        color: Config.mediaPlayerSelectorBackground
                        radius: 5
                    }
                }
            }
        }
    }
}
