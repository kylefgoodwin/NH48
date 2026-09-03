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
            HStack {
                InlineSectionLabel(systemImage: "calendar", title: "Completion Date", color: .blue)
                Spacer()
                Button("Set Today") {
                    withAnimation { mountain.completionDate = Date() }
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                }
                .font(.caption.weight(.semibold))
                .tint(.blue)
                .buttonStyle(.borderless)
            }

            HStack {
                DatePicker("Date", selection: dateBinding, displayedComponents: [.date])
                    .labelsHidden()
                Spacer()
                if mountain.completionDate != nil {
                    Button {
                        withAnimation { mountain.completionDate = nil }
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary.opacity(0.7))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            )
        }
    }
}
