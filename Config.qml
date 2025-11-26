pragma Singleton

import QtQuick
import Quickshell

Singleton {

    /* Theme colors (Catpuccin Mocha) */
    readonly property QtObject colors: QtObject {
        id: colors
        readonly property color rosewaterColor: "#f5e0dc"
        readonly property color flamingoColor: "#f2cdcd"
        readonly property color pinkColor: "#f5c2e7"
        readonly property color mauveColor: "#cba6f7"
        readonly property color redColor: "#f38ba8"
        readonly property color maroonColor: "#eba0ac"
        readonly property color peachColor: "#fab387"
        readonly property color yellowColor: "#f9e2af"
        readonly property color greenColor: "#a6e3a1"
        readonly property color tealColor: "#94e2d5"
        readonly property color skyColor: "#89dceb"
        readonly property color sapphireColor: "#74c7ec"
        readonly property color blueColor: "#89b4fa"
        readonly property color lavenderColor: "#b4befe"
        readonly property color textColor: "#cdd6f4"
        readonly property color subtext1Color: "#bac2de"
        readonly property color subtext0Color: "#a6adc8"
        readonly property color overlay2Color: "#9399b2"
        readonly property color overlay1Color: "#7f849c"
        readonly property color overlay0Color: "#6c7086"
        readonly property color surface2Color: "#585b70"
        readonly property color surface1Color: "#45475a"
        readonly property color surface0Color: "#313244"
        readonly property color baseColor: "#1e1e2e"
        readonly property color mantleColor: "#181825"
        readonly property color crustColor: "#11111b"
    }

    /* Text */
    readonly property color textColor: colors.textColor
    readonly property int fontSize: 10
    readonly property string textFontFamily: "JetBrains Mono"
    readonly property string noLigatureFontFamily: "JetBrains Mono NL"
    readonly property string iconFontFamily: "JetBrains Mono Propo"

    readonly property int iconHeight: 20
    readonly property string chargingIcon: ""
    readonly property string distroIcon: ""
    readonly property color distroColor: colors.textColor

    readonly property string timeFormat: "hh:mm:ss ddd dd/MM"

    /* Statusbar */
    readonly property bool topBar: true
    readonly property bool floating: true

    readonly property int barHeight: 32

    readonly property int componentMargins: 5
    readonly property int componentPadding: 20
    readonly property int componentHeight: 30
    readonly property int componentBorderSize: 2
    readonly property int componentHoverAnimationDuration: 200

    readonly property color barBackground: floating ? "transparent" : Qt.rgba(colors.baseColor.r, colors.baseColor.g, colors.baseColor.b, 0.9)
    readonly property color componentBackground: floating ? colors.baseColor : "transparent"
    readonly property color componentHover: colors.overlay0Color
    readonly property color workspaceInactive: colors.surface0Color
    readonly property color workspaceActive: Qt.rgba(workspacesBorder.r, workspacesBorder.g, workspacesBorder.b, 0.5)
    readonly property color workspaceHover: colors.surface2Color
    readonly property int workspaceActivePadding: 10
    readonly property int workspacePaddingAnimationDuration: 100
    readonly property int workspaceWindowTitleMargin: 5
    readonly property int workspaceWindowTitleFontSize: 12

    readonly property color windowControlsScratchpad: colors.yellowColor
    readonly property color windowControlsMaximize: colors.greenColor
    readonly property color windowControlsClose: colors.redColor

    readonly property string runIcon: ""
    readonly property string runText: "run program"
    readonly property string runCommand: "wofi --show drun"

    readonly property color batteryBorder: floating ? colors.pinkColor : "transparent"
    readonly property color clockBorder: floating ? colors.mauveColor : "transparent"
    readonly property color memoryBorder: floating ? colors.redColor : "transparent"
    readonly property color cpuBorder: floating ? colors.peachColor : "transparent"
    readonly property color systemTrayBorder: floating ? colors.yellowColor : "transparent"
    readonly property color windowControlsBorder: floating ? colors.greenColor : "transparent"
    readonly property color windowNameBorder: floating ? colors.tealColor : "transparent"
    readonly property color runBorder: floating ? colors.sapphireColor : "transparent"
    readonly property color workspacesBorder: floating ? colors.blueColor : "transparent"
    readonly property color iconBorder: floating ? colors.lavenderColor : "transparent"

    readonly property color tooltipBackground: colors.baseColor

    /* OsdSlider */
    readonly property int osdSliderWidth: 400
    readonly property int osdSliderHeight: 40
    readonly property int osdSliderIconSize: 25
    readonly property int osdSliderBarHeight: 5
    readonly property int osdSliderBorderSize: 2
    readonly property int osdSliderMargin: 10

    readonly property color osdSliderBackground: Qt.rgba(colors.baseColor.r, colors.baseColor.g, colors.baseColor.g, 0.7)
    readonly property color osdSliderUnfilled: colors.overlay2Color
    readonly property color osdSliderFilled: colors.textColor

    readonly property color osdVolumeBorder: colors.sapphireColor
    readonly property color osdBrightnessBorder: colors.flamingoColor

    /* Lockscreen */
    readonly property color lockBackground: Qt.rgba(colors.crustColor.r, colors.crustColor.g, colors.crustColor.b, 0.7)

    readonly property int lockClockMargin: 200
    readonly property int lockClockSize: 80
    readonly property int lockDateSize: 20
    readonly property string lockClockFormat: "hh:mm"
    readonly property string lockDateFormat: "ddd dd/MM"

    readonly property int passBoxPadding: 10
    readonly property int passBoxWidth: 400
    readonly property int passBoxBorderWidth: 2
    readonly property string passBoxPlaceholder: "Enter password..."
    readonly property int unlockButtonPadding: 10
    readonly property int abortButtonSize: 30
    readonly property int abortButtonMargin: 10
    readonly property int unlockButtonBorderWidth: 2
    readonly property string unlockButtonText: "Unlock"

    readonly property color passBoxBackground: colors.surface0Color
    readonly property color passBoxBorder: colors.blueColor
    readonly property color unlockButtonBackground: colors.surface0Color
    readonly property color unlockButtonBorder: colors.tealColor
    readonly property color unlockButtonFailBorder: colors.redColor

    readonly property int lockButtonSpacing: 15
    readonly property int lockButtonBottomMargin: 50
    readonly property int lockButtonWidth: 120
    readonly property int lockButtonHeight: 40
    readonly property int lockButtonBorderWidth: 2
    readonly property int lockButtonIconHeight: 15
    readonly property int lockButtonTextSize: 10

    readonly property color lockButtonSelectedBackground: colors.surface0Color
    readonly property color lockButtonBackground: colors.baseColor
    readonly property color lockButtonSelectedBorder: colors.blueColor
    readonly property color lockButtonBorder: colors.overlay0Color

    readonly property bool lockShowMediaPlayer: true
    readonly property int lockMediaPlayerMargin: 50

    /* Session */
    readonly property int sessionButtonSpacing: 15
    readonly property int sessionButtonWidth: 200
    readonly property int sessionButtonHeight: 60
    readonly property int sessionButtonBorderWidth: 2
    readonly property int sessionButtonIconHeight: 20
    readonly property int sessionButtonTextSize: 11
    readonly property int sessionBlur: 32

    readonly property color sessionButtonSelectedBackground: colors.surface0Color
    readonly property color sessionButtonBackground: colors.baseColor
    readonly property color sessionButtonSelectedBorder: colors.blueColor
    readonly property color sessionButtonBorder: colors.overlay0Color

    /* Notifications */
    readonly property int notificationWidth: 350
    readonly property int notificationHeight: 36
    readonly property int notificationMargin: 6
    readonly property int notificationSpacing: 5
    readonly property int notificationBorderWidth: 2
    readonly property int notificationPadding: 20

    readonly property color notificationBorderUrgent: colors.redColor
    readonly property color notificationBorderNormal: colors.blueColor
    readonly property color notificationBorderLow: colors.greenColor

    readonly property int notificationTextSpacing: 5
    readonly property int notificationTitleSize: 14
    readonly property int notificationBodySize: 12
    readonly property color notificationTitleColor: colors.textColor
    readonly property color notificationBodyColor: colors.subtext1Color

    readonly property int notificationDefaultTimeout: 4000

    readonly property bool notificationCenterRight: true
    readonly property int notificationCenterWindowMargin: 6
    readonly property int notificationCenterPadding: 15
    readonly property int notificationCenterIconSize: 30
    readonly property int notificationCenterSpacing: 5

    readonly property color notificationCenterBorder: colors.blueColor
    readonly property color notificationCenterBackground: Qt.rgba(colors.baseColor.r, colors.baseColor.g, colors.baseColor.b, 0.7)
    readonly property color notificationCenterScrollbarActive: colors.overlay1Color
    readonly property color notificationCenterScrollbarInactive: colors.overlay0Color
    readonly property color notificationCenterClose: colors.redColor

    /* Media Player */
    readonly property color mediaPlayerSelectorBorder: colors.blueColor
    readonly property color mediaPlayerSelectorBackground: osdSliderBackground
    readonly property color mediaPlayerSelectorSelected: Qt.rgba(colors.overlay0Color.r, colors.overlay0Color.g, colors.overlay0Color.b, 0.5)
    readonly property color mediaPlayerButtonInactive: colors.overlay0Color
    readonly property color mediaPlayerBarUnfilled: colors.overlay0Color
    readonly property color mediaPlayerBarFilled: colors.textColor

    readonly property int mediaPlayerSmallFontSize: fontSize - 2
    readonly property int mediaPlayerButtonSpacing: 40
    readonly property int mediaPlayerButtonSize: 30
    readonly property int mediaPlayerBarSize: 8
    readonly property int smallMediaPlayerSwitcherSpacing: 15
}
