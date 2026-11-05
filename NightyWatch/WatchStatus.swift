import Observation
import WatchConnectivity

@Observable
final class WatchStatus: NSObject, WCSessionDelegate {
    private(set) var signedIn = false

    func activate() {
        guard WCSession.isSupported() else { return }
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }

    nonisolated func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        apply(session.receivedApplicationContext)
    }

    nonisolated func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        apply(applicationContext)
    }

    private nonisolated func apply(_ context: [String: Any]) {
        let signedIn = context["signedIn"] as? Bool ?? false
        Task { @MainActor in
            self.signedIn = signedIn
        }
    }
}
