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
        let columns: [GridItem] = [GridItem(.adaptive(minimum: 320), spacing: 16)]

        LazyVGrid(columns: columns, spacing: 16) {
            // Trip Log Section
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.blue.opacity(0.12)).frame(width: 28, height: 28)
                        Image(systemName: "calendar.badge.clock").foregroundColor(.blue)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    Text("Trip Log")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }

                CompletionDateInput(mountain: $mountain)
                RatingDifficultyInputs(mountain: $mountain)
            }
            .sectionCardStyle()

            // Hike Stats Section
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.green.opacity(0.12)).frame(width: 28, height: 28)
                        Image(systemName: "figure.hiking").foregroundColor(.green)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    Text("Hike Stats")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }

                HikeStatsInputs(mountain: $mountain)
            }
            .sectionCardStyle()

            // Notes & Tags Section
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.orange.opacity(0.12)).frame(width: 28, height: 28)
                        Image(systemName: "square.and.pencil").foregroundColor(.orange)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    Text("Notes & Tags")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "note.text").foregroundStyle(.orange)
                        Text("Personal Notes").font(.caption).bold().foregroundStyle(.secondary)
                    }
                    TextEditor(text: Binding(
                        get: { mountain.personalNotes ?? "" },
                        set: { mountain.personalNotes = $0.isEmpty ? nil : $0 }
                    ))
                    .frame(minHeight: 100)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                }

                ChipsEditor(title: "Conditions",
                            systemImage: "cloud.sun.rain",
                            items: Binding(
                                get: { mountain.conditions ?? [] },
                                set: { mountain.conditions = $0 }
                            ))

                ChipsEditor(title: "Tags",
                            systemImage: "tag",
                            items: $mountain.tags)
            }
            .sectionCardStyle()

            // Photos Section
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.purple.opacity(0.12)).frame(width: 28, height: 28)
                        Image(systemName: "photo.on.rectangle").foregroundColor(.purple)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    Text("Photos")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }

                PhotosGrid(mountain: $mountain)
            }
            .sectionCardStyle()
        }
        .animation(.snappy, value: mountain)
    }
}

