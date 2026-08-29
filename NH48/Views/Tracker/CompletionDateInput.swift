import SwiftUI

struct CompletionDateInput: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Completion Date").font(.caption).foregroundStyle(.secondary)
            DatePicker(
                "",
                selection: Binding<Date>(unwrapping: $mountain.completionDate, default: Date()),
                displayedComponents: [.date]
            )
            .labelsHidden()
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            )
        }
        .padding(.vertical, 2)
    }
}
