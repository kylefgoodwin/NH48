import SwiftUI

struct MountainCardView: View {
    let mountain: Mountain
    let onToggleCompleted: () -> Void

    private var userImage: UIImage? {
        if let filename = mountain.image, let docImage = ImageStore.loadImage(named: filename) {
            return docImage
        }
        if let firstPhoto = mountain.photoFileNames.first, let docImage = ImageStore.loadImage(named: firstPhoto) {
            return docImage
        }
        return nil
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Image or Gradient
            Group {
                if let image = userImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .fill(
                            mountain.isCompleted
                            ? LinearGradient(colors: [.green.opacity(0.8), .blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            : LinearGradient(colors: [Color(.systemGray4), Color(.systemGray6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .overlay(
                            Image(systemName: "mountain.2.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(.white.opacity(mountain.isCompleted ? 0.9 : 0.4))
                        )
                }
            }
            .frame(height: 180)
            .clipped()

            // Bottom Gradient Overlay for text readability
            LinearGradient(
                colors: [.black.opacity(0.75), .black.opacity(0.2), .clear],
                startPoint: .bottom,
                endPoint: .top
            )

            // Info Content
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(mountain.location.uppercased())
                        .font(.caption2.bold())
                        .tracking(1)
                        .foregroundStyle(.white.opacity(0.8))

                    Text(mountain.name)
                        .font(.title3.bold())
                        .foregroundStyle(.white)

                    HStack(spacing: 8) {
                        Label("\(mountain.elevation) ft", systemImage: "arrow.up.forward")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.9))

                        if mountain.isCompleted {
                            Text("•")
                                .foregroundStyle(.white.opacity(0.6))
                            Label("Completed", systemImage: "checkmark.circle.fill")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.green)
                        }
                    }
                }

                Spacer()

                Button(action: onToggleCompleted) {
                    Image(systemName: mountain.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundStyle(mountain.isCompleted ? .green : .white)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("CompletionToggle")
            }
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 3)
    }
}
