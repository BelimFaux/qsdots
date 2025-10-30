import QtQuick
import Quickshell
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    anchors.fill: parent
    required property ShellScreen screen
    required property int blurRadius

    function captureFrame() {
        screenCapture.captureFrame();
    }

    ScreencopyView {
        id: screenCapture
        anchors.fill: parent
        captureSource: root.screen
        onCaptureSourceChanged: function () {
            if (hasContent)
                screenCapture.captureFrame();
        }
    }

    FastBlur {
        anchors.fill: screenCapture
        source: screenCapture
        radius: root.blurRadius
    }
}
