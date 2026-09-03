import SwiftUI
import UIKit

struct RatingDifficultyInputs: View {
    @Binding var mountain: Mountain
    @State private var animateTap: Bool = false

    // MARK: - Bindings
    private var ratingBinding: Binding<Int> {
        Binding(
            get: { mountain.rating ?? 0 },
            set: { mountain.rating = $0 }
        )
    }

    private var difficultyBinding: Binding<Int> {
        Binding(
            get: { mountain.difficulty ?? 3 },
            set: { mountain.difficulty = $0 }
        )
    }

    private let difficultyLevels: [(level: Int, label: String, color: Color, icon: String)] = [
        (1, "Easy", .green, "leaf.fill"),
        (2, "Moderate", .teal, "figure.walk"),
        (3, "Challenging", .blue, "figure.hiking"),
        (4, "Hard", .orange, "flame.fill"),
        (5, "Extreme", .red, "bolt.fill")
    ]

    private func starView(for star: Int) -> some View {
        let isSelected = ratingBinding.wrappedValue >= star
        return Button {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                ratingBinding.wrappedValue = star
                animateTap.toggle()
            }
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        } label: {
            Image(systemName: isSelected ? "star.fill" : "star")
                .font(.system(size: 26, weight: .semibold))
                .foregroundStyle(
                    isSelected
                    ? AnyShapeStyle(LinearGradient(colors: [Color.yellow, Color.orange], startPoint: .top, endPoint: .bottom))
                    : AnyShapeStyle(Color.primary.opacity(0.18))
                )
                .shadow(color: isSelected ? Color.orange.opacity(0.3) : .clear, radius: 4, y: 2)
                .scaleEffect(animateTap && ratingBinding.wrappedValue == star ? 1.15 : 1.0)
                .frame(width: 36, height: 36)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Set rating to \(star) stars")
    }

    var body: some View {
        VStack(spacing: 14) {
            // MARK: - Rating Card
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    InlineSectionLabel(systemImage: "star.fill", title: "Rating", color: .yellow)
                    Spacer()
                    if ratingBinding.wrappedValue > 0 {
                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                ratingBinding.wrappedValue = 0
                            }
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        } label: {
                            HStack(spacing: 3) {
                                Image(systemName: "arrow.uturn.backward")
                                Text("Reset")
                            }
                            .font(.caption.weight(.bold))
                        }
                        .tint(.yellow)
                        .buttonStyle(.borderless)
                    }
                }

                HStack {
                    HStack(spacing: 6) {
                        ForEach(1...5, id: \.self) { star in
                            starView(for: star)
                        }
                    }

                    Spacer()

                    Text(ratingBinding.wrappedValue > 0 ? "\(ratingBinding.wrappedValue) / 5" : "Unrated")
                        .font(.system(.subheadline, design: .rounded).weight(.bold))
                        .foregroundStyle(ratingBinding.wrappedValue > 0 ? .primary : .secondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(ratingBinding.wrappedValue > 0 ? Color.yellow.opacity(0.18) : Color.primary.opacity(0.05))
                        )
                }
            }
            .padding(12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            )

            // MARK: - Difficulty Card
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    InlineSectionLabel(systemImage: "flame.fill", title: "Difficulty", color: .orange)
                    Spacer()
                    if difficultyBinding.wrappedValue != 3 {
                        Button {
                            withAnimation(.snappy) { difficultyBinding.wrappedValue = 3 }
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        } label: {
                            HStack(spacing: 3) {
                                Image(systemName: "arrow.uturn.backward")
                                Text("Reset")
                            }
                            .font(.caption.weight(.bold))
                        }
                        .tint(.orange)
                        .buttonStyle(.borderless)
                    }
                }

                HStack(spacing: 4) {
                    ForEach(difficultyLevels, id: \.level) { item in
                        let isSelected = difficultyBinding.wrappedValue == item.level
                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                difficultyBinding.wrappedValue = item.level
                            }
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        } label: {
                            VStack(spacing: 2) {
                                Image(systemName: item.icon)
                                    .font(.system(size: 11, weight: .bold))

                                Text(item.label)
                                    .font(.system(size: 10, weight: .bold))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                            }
                            .foregroundStyle(isSelected ? Color.white : item.color)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 2)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(isSelected ? item.color : item.color.opacity(0.12))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(isSelected ? item.color : item.color.opacity(0.2), lineWidth: 1)
                            )
                            .shadow(color: isSelected ? item.color.opacity(0.25) : .clear, radius: 4, y: 2)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            )
        }
    }
}
