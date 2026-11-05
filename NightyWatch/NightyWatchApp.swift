import SwiftUI

@main
struct NightyWatchApp: App {
    @State private var status = WatchStatus()

    var body: some Scene {
        WindowGroup {
            WatchHome(status: status)
                .task { status.activate() }
        }
    }
}

private struct WatchHome: View {
    var status: WatchStatus

    var body: some View {
        VStack(spacing: 8) {
            Image("NightyLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 34)
            Text("Nighty")
                .font(.headline)
            Text(status.signedIn ? "Signed in" : "Not signed in")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("The dashboard stays on your iPhone.")
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 12 / 255, green: 16 / 255, blue: 27 / 255))
    }
}
