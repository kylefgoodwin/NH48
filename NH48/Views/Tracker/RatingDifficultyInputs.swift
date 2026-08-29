import SwiftUI

struct RatingDifficultyInputs: View {
    @Binding var mountain: Mountain

    private var ratingBinding: Binding<Int> {
        Binding(
            get: { mountain.rating ?? 3 },
            set: { mountain.rating = $0 }
        )
    }

    private var difficultyBinding: Binding<Int> {
        Binding(
            get: { mountain.difficulty ?? 3 },
            set: { mountain.difficulty = $0 }
        )
    }

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Rating").font(.caption).foregroundStyle(.secondary)
                HStack {
                    Stepper(value: ratingBinding, in: 1...5) {
                        Text("\(ratingBinding.wrappedValue)")
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
                    Stepper(value: difficultyBinding, in: 1...5) {
                        Text("\(difficultyBinding.wrappedValue)")
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
