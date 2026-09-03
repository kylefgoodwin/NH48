import SwiftUI

struct MountainCardView: View {
    let mountain: Mountain
    let onToggleCompletion: () -> Void

    @EnvironmentObject private var store: MountainStore
    @AppStorage("useMetricUnits") private var useMetricUnits: Bool = false

    private var elevationText: String {
        let feet = mountain.elevation
        if useMetricUnits {
            let meters = Int((Double(feet) * 0.3048).rounded())
            return "\(meters) m"
        } else {
            return "\(feet) ft"
        }
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Card background
            VStack(alignment: .leading, spacing: 10) {
                // Icon / art
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color.cyan.opacity(0.35), Color.blue.opacity(0.35)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 52, height: 52)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.25), lineWidth: 1)
                        )
                    Image(systemName: "mountain.2.fill")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.blue)
                        .shadow(color: Color.blue.opacity(0.2), radius: 3, y: 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 2)

                // Name
                Text(mountain.name)
                    .font(.system(.headline, design: .rounded).weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.85)
                    .fixedSize(horizontal: true, vertical: false)

                .padding(.bottom, mountain.isCompleted ? 28 : 0)

                // Meta
                HStack(spacing: 8) {
                    Label(elevationText, systemImage: "arrow.up.right")
                        .labelStyle(.iconOnly)
                        .overlay(
                            HStack(spacing: 3) {
                                Image(systemName: "arrow.up.right")
                                Text(elevationText)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                            }
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                        )
                        .hidden()

                    Spacer(minLength: 0)

                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                        Text(mountain.location)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .minimumScaleFactor(0.8)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.primary.opacity(0.06), lineWidth: 1)
                    )
            )
            .frame(minHeight: 140)
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .contextMenu { MountainContextMenu(mountain: mountain, store: store) }
            .overlay(alignment: .bottomLeading) {
                if mountain.isCompleted {
                    Text("Completed")
                        .font(.caption2.weight(.bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule().fill(Color.green.opacity(0.18))
                        )
                        .overlay(
                            Capsule().stroke(Color.green.opacity(0.35), lineWidth: 1)
                        )
                        .foregroundStyle(.green)
                        .padding(10)
                        .transition(.opacity.combined(with: .scale))
                }
            }

            // Completion toggle button
            Button {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                    onToggleCompletion()
                }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            } label: {
                Image(systemName: mountain.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(mountain.isCompleted ? .green : .secondary)
                    .shadow(color: mountain.isCompleted ? Color.green.opacity(0.25) : .clear, radius: 3, y: 2)
                    .padding(10)
                    .background(.thinMaterial, in: Circle())
            }
            .buttonStyle(.plain)
            .padding(6)
            .accessibilityLabel(mountain.isCompleted ? "Mark as uncompleted" : "Mark as completed")
        }
        .animation(.snappy, value: mountain.isCompleted)
    }
}

#Preview {
    let store = MountainStore()
    return Group {
        MountainCardView(mountain: store.mountains.first!, onToggleCompletion: {})
            .environmentObject(store)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

