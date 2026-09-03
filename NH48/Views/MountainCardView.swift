import SwiftUI

struct MountainCardView: View {
    let mountain: Mountain
    let onToggleCompleted: () -> Void

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
            // Main card container
            VStack(alignment: .leading, spacing: 0) {
                //That  Decorative top header area
                ZStack(alignment: .topTrailing) {
                    // Vibrant, premium gradient depending on completion status
                    LinearGradient(
                        colors: mountain.isCompleted
                            ? [.emeraldGradientStart, .emeraldGradientEnd]
                            : [.slateGradientStart, .slateGradientEnd],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Stylized mountain background graphic
                    Image(systemName: "mountain.2.fill")
                        .font(.system(size: 54, weight: .bold))
                        .foregroundStyle(
                            mountain.isCompleted
                                ? .white.opacity(0.22)
                                : .white.opacity(0.12)
                        )
                        .offset(x: 10, y: 10)
                }
                .frame(height: 75)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 18,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 18,
                        style: .continuous
                    )
                )

                // Bottom text / information panel
                VStack(alignment: .leading, spacing: 6) {
                    // Location/Range
                    Text(mountain.location.uppercased())
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    // Mountain Name
                    Text(mountain.name)
                        .font(.system(.headline, design: .rounded).weight(.bold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    // Stats row (Fixed height container to prevent vertical layout shifts!)
                    HStack(spacing: 8) {
                        Label(elevationText, systemImage: "arrow.up.right")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                        
                        Spacer(minLength: 0)
                        
                        if mountain.isCompleted {
                            Text("Completed")
                                .font(.system(size: 9, weight: .bold))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2.5)
                                .background(Color.green.opacity(0.15))
                                .foregroundStyle(.green)
                                .clipShape(Capsule())
                        }
                    }
                    .frame(height: 18)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.primary.opacity(0.06), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)

            // Absolute positioned floating completion button
            Button {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                    onToggleCompleted()
                }
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            } label: {
                Image(systemName: mountain.isCompleted ? "checkmark.circle.fill" : "plus.circle")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(mountain.isCompleted ? .white : .white.opacity(0.85))
                    .shadow(color: .black.opacity(0.15), radius: 2, y: 1)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(mountain.isCompleted ? Color.green : Color.white.opacity(0.25))
                    )
            }
            .buttonStyle(.plain)
            .padding(10)
            .accessibilityIdentifier("CompletionToggle")
        }
        .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

// Attractive gradients to provide high-end UI aesthetics
extension Color {
    static let slateGradientStart = Color(red: 0.35, green: 0.41, blue: 0.47)
    static let slateGradientEnd = Color(red: 0.20, green: 0.24, blue: 0.28)
    
    static let emeraldGradientStart = Color(red: 0.15, green: 0.68, blue: 0.37)
    static let emeraldGradientEnd = Color(red: 0.16, green: 0.50, blue: 0.73)
}

#Preview {
    let mockMountain = Mountain(
        id: UUID(),
        name: "Mount Lafayette",
        elevation: 5249,
        location: "Franconia Ridge",
        description: nil,
        latitude: nil,
        longitude: nil,
        isCompleted: false,
        image: nil,
        personalNotes: nil,
        completionDate: nil,
        rating: nil,
        difficulty: nil,
        conditions: nil,
        distanceMiles: nil,
        elevationGain: nil,
        durationMinutes: nil,
        tags: [],
        photoFileNames: []
    )
    
    return Group {
        MountainCardView(mountain: mockMountain, onToggleCompleted: {})
            .frame(width: 170)
        
        var completedMock = mockMountain
        let _ = completedMock.isCompleted = true
        MountainCardView(mountain: completedMock, onToggleCompleted: {})
            .frame(width: 170)
    }
    .padding()
    .environmentObject(MountainStore())
    .previewLayout(.sizeThatFits)
}
