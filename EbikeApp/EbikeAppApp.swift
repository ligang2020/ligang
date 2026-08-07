import SwiftUI

@main
struct EbikeAppApp: App {
    @StateObject private var connection = ConnectionViewModel()

    var body: some Scene {
        WindowGroup { RootView().environmentObject(connection) }
    }
}
