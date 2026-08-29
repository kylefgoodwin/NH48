import SwiftUI

struct CompletionDateInput: View {
    @Binding var mountain: Mountain

    private var dateBinding: Binding<Date> {
        Binding(
            get: { mountain.completionDate ?? Date() },
            set: { mountain.completionDate = $0 }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Completion Date").font(.caption).foregroundStyle(.secondary)
            DatePicker(
                "",
                selection: dateBinding,
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
