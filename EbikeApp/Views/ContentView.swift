import SwiftUI

struct ContentView: View {
    @StateObject private var model = AppViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch model.selectedTab {
                case 0: HomeView(model: model)
                case 1: RideView(model: model)
                case 2: VehicleMapView(model: model)
                case 3: HomeKitView(model: model)
                default: ProfileView(model: model)
                }
            }
            .transition(reduceMotion ? .opacity : .opacity.combined(with: .scale(scale: 0.985)))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            FloatingTabBar(selection: $model.selectedTab).padding(.bottom, 7)

            if model.showingToast {
                Label(model.toastMessage, systemImage: "checkmark.circle.fill")
                    .font(.subheadline.weight(.semibold)).padding(.horizontal, 16).padding(.vertical, 11)
                    .background(.regularMaterial, in: Capsule()).shadow(radius: 16, y: 8)
                    .transition(.move(edge: .bottom).combined(with: .opacity)).padding(.bottom, 86)
            }
        }
        .tint(Color(red: 0.039, green: 0.518, blue: 1))
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
