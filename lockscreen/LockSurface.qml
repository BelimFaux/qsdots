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
            color: Theme.lockBackground
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
            topMargin: Theme.abortButtonMargin
            leftMargin: Theme.abortButtonMargin
        }

        iconString: ""
        iconColor: Theme.textColor
        fontSize: Theme.abortButtonSize
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
            topMargin: Theme.lockClockMargin
        }

        renderType: Text.NativeRendering
        color: Theme.textColor
        font.family: Theme.textFontFamily
        font.pointSize: Theme.lockClockSize

        text: Time.formattedTime(Theme.lockClockFormat)
    }

    Label {
        id: date

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: clock.bottom
        }

        renderType: Text.NativeRendering
        color: Theme.textColor
        font.family: Theme.textFontFamily
        font.pointSize: Theme.lockDateSize

        text: Time.formattedTime(Theme.lockDateFormat)
    }

    ColumnLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
        }

        Label {
            text: root.context.pamMessage === "" ? "(Press Enter to scan fingerprint)" : root.context.pamMessage
            font.family: Theme.textFontFamily
            color: Theme.textColor
        }

        RowLayout {
            TextField {
                id: passwordBox
                padding: Theme.passBoxPadding
                leftInset: -5

                background: Rectangle {
                    implicitWidth: Theme.passBoxWidth
                    radius: height / 3
                    color: Theme.passBoxBackground
                    border.color: Theme.passBoxBorder
                    border.width: passwordBox.enabled ? Theme.passBoxBorderWidth : 0

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
                placeholderText: Theme.passBoxPlaceholder
                font.family: Theme.textFontFamily

                placeholderTextColor: Theme.textColor
                passwordCharacter: '*'
                color: Theme.textColor

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
                    text: Theme.unlockButtonText
                    font.family: Theme.textFontFamily
                    color: Theme.textColor
                }
                padding: Theme.unlockButtonPadding

                // don't steal focus from the text box
                focusPolicy: Qt.NoFocus

                background: Rectangle {
                    radius: height / 3
                    color: Theme.unlockButtonBackground
                    border.color: root.context.showFailure ? Theme.unlockButtonFailBorder : Theme.unlockButtonBorder
                    border.width: root.context.unlockInProgress ? 0 : Theme.unlockButtonBorderWidth

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
            visible: Theme.lockShowMediaPlayer
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: Theme.lockMediaPlayerMargin
        }
    }

    RowLayout {
        spacing: Theme.lockButtonSpacing
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Theme.lockButtonBottomMargin
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
