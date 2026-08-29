import SwiftUI

struct MountainTrackerView: View {
    @Binding var mountain: Mountain

    var body: some View {
        List {
            // Trip Log
            Section(header: Text("Trip Log").foregroundColor(.secondary)) {
                CompletionDateInput(mountain: $mountain)
                RatingDifficultyInputs(mountain: $mountain)
            }
            .sectionCardStyle()

            // Hike Stats
            Section(header: Text("Hike Stats").font(.footnote).foregroundColor(.secondary)) {
                HikeStatsInputs(mountain: $mountain)
            }
            .sectionCardStyle()

            // Notes & Tags
            Section(header: Text("Notes & Tags").font(.footnote).foregroundColor(.secondary)) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "note.text").foregroundStyle(.secondary)
                        Text("Personal Notes").font(.caption).foregroundStyle(.secondary)
                    }
                    TextEditor(text: Binding<String>(unwrapping: $mountain.personalNotes, default: ""))
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
                            items: Binding<[String]>(unwrapping: $mountain.conditions, default: []))
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
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemGroupedBackground)], startPoint: .top, endPoint: .bottom)
        )
    }
}
