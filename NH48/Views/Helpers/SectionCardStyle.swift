import SwiftUI

struct SectionCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listRowBackground(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(colors: [Color(.secondarySystemBackground).opacity(0.9), Color(.systemBackground).opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            )
    }
}

extension View {
    func sectionCardStyle() -> some View { modifier(SectionCardStyle()) }
}
