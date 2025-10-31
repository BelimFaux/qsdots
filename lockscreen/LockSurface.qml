import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Fusion

import qs
import qs.widgets
import qs.services
import qs.mediaplayer

Rectangle {
    id: root
    required property LockContext context
    anchors.fill: parent

    Image {
        id: background
        anchors.fill: parent
        source: Wallpaper.currentImagePath
        Rectangle {
            anchors.fill: parent
            color: Config.lockBackground
        }
    }

    FastBlur {
        anchors.fill: background
        source: background
        radius: 32
    }

    ClickableIcon {
        id: closeButton

        anchors {
            top: root.top
            left: root.left
            topMargin: Config.abortButtonMargin
            leftMargin: Config.abortButtonMargin
        }

        iconString: ""
        iconColor: Config.textColor
        fontSize: Config.abortButtonSize
        clickAction: function () {
            root.context.abortFingerprint();
        }
        visible: root.context.fingerprintUnlock
    }

    Label {
        id: clock

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: Config.lockClockMargin
        }

        renderType: Text.NativeRendering
        color: Config.textColor
        font.family: Config.textFontFamily
        font.pointSize: Config.lockClockSize

        text: Time.formattedTime(Config.lockClockFormat)
    }

    Label {
        id: date

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: clock.bottom
        }

        renderType: Text.NativeRendering
        color: Config.textColor
        font.family: Config.textFontFamily
        font.pointSize: Config.lockDateSize

        text: Time.formattedTime(Config.lockDateFormat)
    }

    ColumnLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
        }

        Label {
            text: root.context.pamMessage === "" ? "(Press Enter to scan fingerprint)" : root.context.pamMessage
            font.family: Config.textFontFamily
            color: Config.textColor
        }

        RowLayout {
            TextField {
                id: passwordBox
                padding: Config.passBoxPadding
                leftInset: -5

                background: Rectangle {
                    implicitWidth: Config.passBoxWidth
                    radius: height / 3
                    color: Config.passBoxBackground
                    border.color: Config.passBoxBorder
                    border.width: passwordBox.enabled ? Config.passBoxBorderWidth : 0

                    Behavior on border.width {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                focus: true
                enabled: !root.context.unlockInProgress
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhSensitiveData
                placeholderText: Config.passBoxPlaceholder
                font.family: Config.textFontFamily

                placeholderTextColor: Config.textColor
                passwordCharacter: '*'
                color: Config.textColor

                onTextChanged: root.context.currentText = this.text
                onAccepted: root.context.tryUnlock()

                Connections {
                    target: root.context

                    function onCurrentTextChanged() {
                        passwordBox.text = root.context.currentText;
                    }
                }
            }

            Button {
                contentItem: Text {
                    text: Config.unlockButtonText
                    font.family: Config.textFontFamily
                    color: Config.textColor
                }
                padding: Config.unlockButtonPadding

                // don't steal focus from the text box
                focusPolicy: Qt.NoFocus

                background: Rectangle {
                    radius: height / 3
                    color: Config.unlockButtonBackground
                    border.color: root.context.showFailure ? Config.unlockButtonFailBorder : Config.unlockButtonBorder
                    border.width: root.context.unlockInProgress ? 0 : Config.unlockButtonBorderWidth

                    Behavior on border.width {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                enabled: !root.context.unlockInProgress
                onClicked: root.context.tryUnlock()
            }
        }

        SmallMediaPlayer {
            visible: Config.lockShowMediaPlayer
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: Config.lockMediaPlayerMargin
        }
    }

    RowLayout {
        spacing: Config.lockButtonSpacing
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Config.lockButtonBottomMargin
        }

        LockButton {
            title: "Shutdown"
            commands: ["sh", "-c", "systemctl poweroff || loginctl poweroff"]
            iconChar: "󰐥"
        }

        LockButton {
            title: "Reboot"
            commands: ["sh", "-c", "reboot || loginctl reboot"]
            iconChar: "󰑓"
        }

        LockButton {
            title: "Sleep"
            iconChar: "󰤄"
            commands: ["sh", "-c", "systemctl suspend || loginctl suspend"]
        }

        LockButton {
            title: "Log out"
            commands: ["sh", "-c", "pkill Hyprland"]
            iconChar: "󰍃"
        }
    }
}
