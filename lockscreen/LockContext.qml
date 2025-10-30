import Quickshell
import Quickshell.Services.Pam

Scope {
    id: root
    signal unlocked

    property string currentText: ""
    property bool unlockInProgress: false
    property bool fingerprintUnlock: false
    property bool showFailure: false
    property string pamMessage: ""

    onCurrentTextChanged: showFailure = false

    function tryUnlock() {
        root.unlockInProgress = true;
        if (currentText !== "") {
            passwordPam.start();
        } else {
            root.fingerprintUnlock = true;
            fingerprintPam.start();
        }
    }

    function abortFingerprint() {
        if (!root.fingerprintUnlock)
            return;
        fingerprintPam.abort();
        root.pamMessage = "";
        root.currentText = "";
        root.fingerprintUnlock = false;
        root.unlockInProgress = false;
    }

    PamContext {
        id: passwordPam

        configDirectory: "pam"
        config: "password.conf"

        onPamMessage: {
            if (this.messageIsError)
                root.pamMessage = this.message;
            if (this.responseRequired) {
                this.respond(root.currentText);
            }
        }

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.pamMessage = "";
                root.currentText = "";
                root.unlocked();
            } else {
                root.currentText = "";
                root.showFailure = true;
            }

            root.unlockInProgress = false;
        }
    }

    // the pam stack is serialised, so unlocking both with password and fingerprint requires seperate auth stacks
    PamContext {
        id: fingerprintPam

        configDirectory: "pam"
        config: "fingerprint.conf"

        onPamMessage: {
            root.pamMessage = this.message;
        }

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.pamMessage = "";
                root.currentText = "";
                root.unlocked();
            } else {
                root.currentText = "";
                root.showFailure = true;
            }

            root.fingerprintUnlock = false;
            root.unlockInProgress = false;
        }
    }
}
