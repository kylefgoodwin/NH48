import SwiftUI

struct ChipsEditor: View {
    let title: String
    let systemImage: String
    @Binding var items: [String]
    @State private var input: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: systemImage).foregroundStyle(.secondary)
                Text(title).font(.caption).foregroundStyle(.secondary)
            }

            // Chips
            if !items.isEmpty {
                FlowLayout(items: items) { item in
                    HStack(spacing: 6) {
                        Text(item)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.15))
                            .clipShape(Capsule())
                        Button(action: { remove(item) }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.caption)
                                .padding(4)
                                .background(Circle().fill(Color.black.opacity(0.15)))
                        }
                        .buttonStyle(.plain)
                        .contentShape(Circle())
                    }
                    .fixedSize()
                }
                .padding(.bottom, 4)
            }

            HStack(spacing: 8) {
                TextField("Add \(title.lowercased())", text: $input)
                    .textInputAutocapitalization(.words)
                Button(action: add) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            )
        }
    }

    private func add() {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if !items.contains(trimmed) {
            items.append(trimmed)
        }
        input = ""
    }

    private func remove(_ item: String) {
        if let idx = items.firstIndex(of: item) {
            items.remove(at: idx)
        }
    }
}
