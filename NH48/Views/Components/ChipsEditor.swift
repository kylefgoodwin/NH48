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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(items, id: \.self) { item in
                            HStack(spacing: 0) {
                                Text(item)
                                    .font(.caption)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 4)
                                    .padding(.vertical, 4)
                                    .foregroundColor(.primary)
                                
                                // Reliable tap target for deleting
                                Image(systemName: "xmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.secondary.opacity(0.7))
                                    .padding(.vertical, 6)
                                    .padding(.trailing, 8)
                                    .padding(.leading, 4)
                                    .contentShape(Rectangle())
                                    .accessibilityIdentifier("DeleteTag-\(item)") // Added for UI testing
                                    .onTapGesture {
                                        remove(item)
                                    }
                            }
                            .background(Color.blue.opacity(0.12))
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal, 1)
                }
                .padding(.bottom, 4)
            }

            HStack(spacing: 8) {
                TextField("Add \(title.lowercased())", text: $input)
                    .textInputAutocapitalization(.words)
                    .accessibilityIdentifier("TagInput-\(title)") // Added for UI testing
                
                Button(action: add) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .accessibilityIdentifier("AddTagButton-\(title)") // Added for UI testing
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
