import SwiftUI

struct VehicleMapView: View {
    @ObservedObject var model: AppViewModel
    @State private var selectedLayer = "实时位置"
    private let layers = ["实时位置", "历史轨迹", "电子围栏"]
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                MockMap().ignoresSafeArea(edges: .top)
                VStack(spacing: 12) {
                    HStack { Image(systemName: "magnifyingglass"); Text("搜索地点或车辆").foregroundStyle(.secondary); Spacer(); Image(systemName: "mic.fill").foregroundStyle(.secondary) }.padding(14).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16)).shadow(radius: 12, y: 5)
                    Spacer()
                    HStack(spacing: 8) { ForEach(layers, id: \.self) { layer in Button { withAnimation(.easeOut(duration: 0.18)) { selectedLayer = layer } } label: { Text(layer).font(.caption.weight(.semibold)).padding(.horizontal, 12).padding(.vertical, 9).background(selectedLayer == layer ? Color.accentColor : Color.primary.opacity(0.08), in: Capsule()).foregroundStyle(selectedLayer == layer ? .white : .primary) }.buttonStyle(.plain) } }.frame(maxWidth: .infinity, alignment: .leading)
                    GlassCard(padding: 14) { HStack(spacing: 14) { Image(systemName: "bicycle.circle.fill").font(.system(size: 38)).foregroundStyle(.blue); VStack(alignment: .leading, spacing: 2) { Text(model.vehicle.name).font(.headline); Text("距你 128 m · 已锁定").font(.caption).foregroundStyle(.secondary) }; Spacer(); Button { model.perform("正在规划到车辆的路线") } label: { Image(systemName: "arrow.triangle.turn.up.right.diamond.fill").font(.title3) }.buttonStyle(.borderedProminent).clipShape(Circle()) } }
                }.padding(18).padding(.bottom, 92)
            }.navigationTitle("地图").navigationBarTitleDisplayMode(.inline).toolbar { ToolbarItem(placement: .topBarTrailing) { Button { model.perform("已定位到家庭") } label: { Image(systemName: "house.fill") } } }
        }
    }
}
