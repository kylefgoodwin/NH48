import SwiftUI

struct InlineSectionLabel: View {
    let systemImage: String
    let title: String
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: systemImage)
                .font(.caption)
                .foregroundStyle(color)
            Text(title)
                .font(.caption).bold()
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
    }
}

#Preview {
    InlineSectionLabel(systemImage: "calendar", title: "Completion Date", color: .blue)
        .padding()
}
