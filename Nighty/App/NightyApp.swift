import SwiftUI

@main
struct NightyApp: App {
    @State private var session = Session()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(session)
                .task {
                    PhoneWatchBridge.shared.activate()
                    PhoneWatchBridge.shared.send(signedIn: session.credentials != nil)
                }
                .onChange(of: session.credentials != nil) { _, signedIn in
                    PhoneWatchBridge.shared.send(signedIn: signedIn)
                }
        }
    }
}
