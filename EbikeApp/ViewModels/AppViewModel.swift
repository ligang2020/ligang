import SwiftUI

@MainActor
final class AppViewModel: ObservableObject {
    @Published var vehicle = Vehicle.demo
    @Published var selectedTab = 0
    @Published var isLocked = true
    @Published var isSaddleOpen = false
    @Published var showingSettings = false
    @Published var showingRideDetail = false
    @Published var showingToast = false
    @Published var toastMessage = ""

    let rides = Ride.demo

    func perform(_ message: String) {
        toastMessage = message
        withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) { showingToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut(duration: 0.2)) { self.showingToast = false }
        }
    }
}
