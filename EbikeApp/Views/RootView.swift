import SwiftUI

struct RootView: View {
    @EnvironmentObject private var connection: ConnectionViewModel

    var body: some View {
        Group {
            if connection.isConnected {
                ContentView().transition(.opacity)
            } else {
                ConnectionView().transition(.opacity)
            }
        }
        .animation(Motion.transition, value: connection.isConnected)
    }
}
