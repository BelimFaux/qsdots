import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs
import qs.widgets

Rectangle {
    id: root
    color: "transparent"
    implicitHeight: content.height
    implicitWidth: content.width

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

        MediaControls {
            player: root.player
        }

        MediaInfo {
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: root.width
            player: root.player
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: Config.smallMediaPlayerSwitcherSpacing
            spacing: Config.smallMediaPlayerSwitcherSpacing

            ClickableIcon {
                iconString: ""
                // opacity instead of visible so that the space gets occupied
                opacity: root.selectedPlayer - 1 >= 0 ? 1 : 0
                iconColor: Config.textColor
                fontSize: Config.fontSize
                clickAction: function () {
                    root.selectedPlayer -= 1;
                }
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                text: qsTr((root.player?.identity ?? "") || "No Player selected")
                font.family: Config.textFontFamily
                font.pointSize: Config.fontSize
                color: Config.textColor
            }

            ClickableIcon {
                iconString: ""
                opacity: root.selectedPlayer + 1 < Mpris.players.values.length ? 1 : 0
                iconColor: Config.textColor
                fontSize: Config.fontSize
                clickAction: function () {
                    root.selectedPlayer += 1;
                }
            }
        }
    }
}
