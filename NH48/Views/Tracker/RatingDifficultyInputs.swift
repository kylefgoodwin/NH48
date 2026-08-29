import SwiftUI

struct RatingDifficultyInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Rating").font(.caption).foregroundStyle(.secondary)
                HStack {
                    Stepper(value: Binding<Int>(unwrapping: $mountain.rating, default: 3), in: 1...5) {
                        Text("\(Binding<Int>(unwrapping: $mountain.rating, default: 3).wrappedValue)")
                            .font(.body.monospacedDigit())
                    }
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
            VStack(alignment: .leading, spacing: 6) {
                Text("Difficulty").font(.caption).foregroundStyle(.secondary)
                HStack {
                    Stepper(value: Binding<Int>(unwrapping: $mountain.difficulty, default: 3), in: 1...5) {
                        Text("\(Binding<Int>(unwrapping: $mountain.difficulty, default: 3).wrappedValue)")
                            .font(.body.monospacedDigit())
                    }
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
    }
}
