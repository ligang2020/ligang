import SwiftUI

struct FloatingTabBar: View {
    @Binding var selection: Int
    let items: [(String, String)] = [("house.fill", "首页"), ("figure.outdoor.cycle", "骑行"), ("map.fill", "地图"), ("homekit", "HomeKit"), ("person.crop.circle.fill", "我的")]
    var body: some View {
        HStack(spacing: 2) {
            ForEach(items.indices, id: \.self) { index in
                Button { withAnimation(.spring(response: 0.34, dampingFraction: 0.78)) { selection = index } } label: {
                    VStack(spacing: 4) {
                        Image(systemName: items[index].0).font(.system(size: 20, weight: .semibold))
                            .symbolEffect(.bounce, value: selection == index)
                        Text(items[index].1).font(.caption2.weight(.semibold))
                    }.foregroundStyle(selection == index ? Color.accentColor : .secondary).frame(maxWidth: .infinity).padding(.vertical, 8)
                }.buttonStyle(.plain)
            }
        }.padding(.horizontal, 8).padding(.top, 6).padding(.bottom, 4)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 26, style: .continuous).strokeBorder(Color.primary.opacity(0.08), lineWidth: 0.7))
            .shadow(color: .black.opacity(0.12), radius: 24, y: 10)
            .padding(.horizontal, 14)
    }
}
