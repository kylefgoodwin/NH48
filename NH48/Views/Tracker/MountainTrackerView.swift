import SwiftUI

struct MountainTrackerView: View {
    @Binding var mountain: Mountain

    private var personalNotesBinding: Binding<String> {
        Binding(
            get: { mountain.personalNotes ?? "" },
            set: { mountain.personalNotes = $0.isEmpty ? nil : $0 }
        )
    }

    private var conditionsBinding: Binding<[String]> {
        Binding(
            get: { mountain.conditions ?? [] },
            set: { mountain.conditions = $0 }
        )
    }

    var body: some View {
        VStack(spacing: 16) {
            // Trip Log
            VStack(alignment: .leading, spacing: 8) {
                Text("Trip Log")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                CompletionDateInput(mountain: $mountain)
                RatingDifficultyInputs(mountain: $mountain)
            }
            .sectionCardStyle()

            // Hike Stats
            VStack(alignment: .leading, spacing: 8) {
                Text("Hike Stats")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                HikeStatsInputs(mountain: $mountain)
            }
            .sectionCardStyle()

            // Notes & Tags
            VStack(alignment: .leading, spacing: 8) {
                Text("Notes & Tags")
                    .font(.footnote)
                    .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "note.text").foregroundStyle(.secondary)
                        Text("Personal Notes").font(.caption).foregroundStyle(.secondary)
                    }
                    TextEditor(text: personalNotesBinding)
                        .frame(minHeight: 100)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                        )
                }
                .padding(.vertical, 2)

                ChipsEditor(title: "Conditions",
                            systemImage: "cloud.sun.rain",
                            items: conditionsBinding)
                .padding(.vertical, 2)

                ChipsEditor(title: "Tags",
                            systemImage: "tag",
                            items: $mountain.tags)
                .padding(.vertical, 2)
            }
            .sectionCardStyle()

            // Photos
            PhotosGrid(mountain: $mountain)
        }
    }
}
