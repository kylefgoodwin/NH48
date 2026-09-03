import SwiftUI

struct ChipsEditor: View {
    let title: String
    let systemImage: String
    @Binding var items: [String]
    @State private var input: String = ""

    private var suggestions: [String] {
        if title.lowercased().contains("condition") {
            return ["Sunny", "Clear", "Snow", "Ice", "Muddy", "Windy", "Foggy"]
        } else {
            return ["Solo", "Group", "Winter", "Sunrise", "Sunset", "Dog Friendly"]
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: systemImage).foregroundStyle(.secondary)
                Text(title).font(.caption).bold().foregroundStyle(.secondary)
            }

            // Existing Chips
            if !items.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(items, id: \.self) { item in
                            HStack(spacing: 4) {
                                Text(item)
                                    .font(.caption.weight(.medium))
                                    .padding(.leading, 10)
                                    .padding(.vertical, 6)
                                    .foregroundColor(.primary)

                                Image(systemName: "xmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.secondary.opacity(0.8))
                                    .padding(.trailing, 8)
                                    .padding(.vertical, 6)
                                    .contentShape(Rectangle())
                                    .accessibilityIdentifier("DeleteTag-\(item)")
                                    .onTapGesture {
                                        if let idx = items.firstIndex(of: item) {
                                            items.remove(at: idx)
                                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                        }
                                    }
                            }
                            .background(
                                Capsule()
                                    .fill(Color.accentColor.opacity(0.12))
                                    .overlay(
                                        Capsule().stroke(Color.accentColor.opacity(0.25), lineWidth: 1)
                                    )
                            )
                            .shadow(color: Color.black.opacity(0.03), radius: 2, y: 1)
                        }
                    }
                }
            }

            // Suggestions List
            let unusedSuggestions = suggestions.filter { !items.contains($0) }
            if !unusedSuggestions.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(unusedSuggestions, id: \.self) { suggestion in
                            Button {
                                withAnimation(.snappy) {
                                    if !items.contains(suggestion) {
                                        items.append(suggestion)
                                    }
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 9, weight: .bold))
                                    Text(suggestion)
                                        .font(.caption2.weight(.medium))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .foregroundColor(.secondary)
                                .background(
                                    Capsule()
                                        .fill(Color.primary.opacity(0.04))
                                        .overlay(Capsule().stroke(Color.primary.opacity(0.08), lineWidth: 1))
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }

            // Input TextField
            HStack(spacing: 8) {
                TextField("Add \(title.lowercased())", text: $input)
                    .textInputAutocapitalization(.words)
                    .accessibilityIdentifier("TagInput-\(title)")

                Button(action: add) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
                .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .accessibilityIdentifier("AddTagButton-\(title)")
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

    private func add() {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if !items.contains(trimmed) {
            items.append(trimmed)
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
        input = ""
    }
}
