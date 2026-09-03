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
    
    private let difficultyLevels: [(level: Int, label: String, color: Color)] = [
        (1, "Easy", .green),
        (2, "Moderate", .teal),
        (3, "Challenging", .blue),
        (4, "Hard", .orange),
        (5, "Extreme", .red)
    ]
    
    private func starView(for star: Int) -> some View {
        Image(systemName: ratingBinding.wrappedValue >= star ? "star.fill" : "star")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 32, height: 32)
            .foregroundStyle(ratingBinding.wrappedValue >= star
                ? AnyShapeStyle(LinearGradient(colors: [Color.yellow, Color.orange], startPoint: .top, endPoint: .bottom))
                : AnyShapeStyle(Color.gray.opacity(0.22)))
            .shadow(color: ratingBinding.wrappedValue >= star ? Color.yellow.opacity(0.34) : Color.clear, radius: 4, y: 2)
            .padding(4)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                    ratingBinding.wrappedValue = star
                    animateTap.toggle()
                }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
            .onLongPressGesture(minimumDuration: 0.4) {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                    ratingBinding.wrappedValue = 0
                }
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
            .accessibilityLabel("Set rating to \(star) stars")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Rating Box
            VStack(alignment: .leading, spacing: 6) {
                InlineSectionLabel(systemImage: "star.fill", title: "Rating", color: .yellow)
                HStack(spacing: 10) {
                    HStack(spacing: 8) {
                        ForEach(1...5, id: \.self) { star in
                            starView(for: star)
                                .scaleEffect(animateTap && ratingBinding.wrappedValue == star ? 1.08 : 1.0)
                                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: animateTap)
                        }
                    }
                    Spacer()
                    if ratingBinding.wrappedValue > 0 {
                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                ratingBinding.wrappedValue = 0
                            }
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.uturn.backward")
                                Text("Reset")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                            }
                            .font(.caption.weight(.semibold))
                        }
                        .buttonStyle(.borderless)
                        .layoutPriority(1)
                        .tint(.yellow)
                        .accessibilityLabel("Reset rating")
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
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Star rating")
                .accessibilityValue("\(ratingBinding.wrappedValue) out of 5")
            }

            // Difficulty Box
            VStack(alignment: .leading, spacing: 6) {
                InlineSectionLabel(systemImage: "flame.fill", title: "Difficulty", color: .orange)
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        let selected = difficultyLevels.first { $0.level == difficultyBinding.wrappedValue } ?? difficultyLevels[2]
                        Text(selected.label)
                            .font(.headline.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(selected.color.gradient.opacity(0.22)))
                            .foregroundColor(selected.color)
                        Spacer()
                        if difficultyBinding.wrappedValue != 3 {
                            Button {
                                withAnimation(.snappy) { difficultyBinding.wrappedValue = 3 }
                                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.uturn.backward")
                                    Text("Reset")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                }
                                .font(.caption.weight(.semibold))
                            }
                            .buttonStyle(.borderless)
                            .layoutPriority(1)
                            .tint(.orange)
                            .accessibilityLabel("Reset difficulty")
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(difficultyLevels, id: \.level) { item in
                                Button(action: {
                                    withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                        difficultyBinding.wrappedValue = item.level
                                        animateTap.toggle()
                                    }
                                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                }) {
                                    Text("\(item.level) \(item.label)")
                                        .font(.subheadline.weight(.semibold))
                                        .lineLimit(1)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .foregroundStyle(difficultyBinding.wrappedValue == item.level ? Color.white : item.color)
                                        .padding(.horizontal, 12)
                                        .frame(height: 36)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(difficultyBinding.wrappedValue == item.level ? item.color : Color.primary.opacity(0.06))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(difficultyBinding.wrappedValue == item.level ? item.color.opacity(0.9) : Color.primary.opacity(0.08), lineWidth: 1)
                                        )
                                        .shadow(color: item.color.opacity(difficultyBinding.wrappedValue == item.level ? 0.18 : 0), radius: 4, y: 2)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel("Set difficulty to \(item.label)")
                            }
                        }
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
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Difficulty Selector")
            }
        }
    }
}

