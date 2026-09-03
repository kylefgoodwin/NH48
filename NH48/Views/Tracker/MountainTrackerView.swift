import SwiftUI

struct MountainTrackerView: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(spacing: 14) {
            // Trip Log Section
            TrackerSection(
                title: "Trip Log",
                iconName: "calendar.badge.clock",
                colors: [.blue, .teal]
            ) {
                CompletionDateInput(mountain: $mountain)
                RatingDifficultyInputs(mountain: $mountain)
            }

            // Hike Stats Section
            TrackerSection(
                title: "Hike Stats",
                iconName: "figure.hiking",
                colors: [.green, .mint]
            ) {
                HikeStatsInputs(mountain: $mountain)
            }

            // Notes & Tags Section
            TrackerSection(
                title: "Notes & Tags",
                iconName: "square.and.pencil",
                colors: [.orange, .yellow]
            ) {
                NotesAndTagsInputs(mountain: $mountain)
            }

            // Photos Section
            TrackerSection(
                title: "Photos",
                iconName: "photo.on.rectangle",
                colors: [.purple, .pink]
            ) {
                PhotosGrid(mountain: $mountain)
            }
        }
        .animation(.snappy, value: mountain)
    }
}

// MARK: - Reusable Section Container
struct TrackerSection<Content: View>: View {
    let title: String
    let iconName: String
    let colors: [Color]
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 28, height: 28)
                    Image(systemName: iconName)
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .bold))
                }
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
            }

            content()
        }
        .sectionCardStyle()
    }
}

// MARK: - Notes & Tags Inputs Subview
struct NotesAndTagsInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Image(systemName: "note.text")
                        .foregroundStyle(.orange)
                        .font(.caption.bold())
                    Text("Personal Notes")
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                }

                TextEditor(text: Binding(
                    get: { mountain.personalNotes ?? "" },
                    set: { mountain.personalNotes = $0.isEmpty ? nil : $0 }
                ))
                .frame(minHeight: 90)
                .padding(8)
                .scrollContentBackground(.hidden)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                )
            }

            ChipsEditor(
                title: "Conditions",
                systemImage: "cloud.sun.rain",
                items: Binding(
                    get: { mountain.conditions ?? [] },
                    set: { mountain.conditions = $0 }
                )
            )

            ChipsEditor(
                title: "Tags",
                systemImage: "tag",
                items: $mountain.tags
            )
        }
    }
}
