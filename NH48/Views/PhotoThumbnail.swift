import SwiftUI

struct PhotoThumbnail: View {
    let filename: String
    @Binding var mountain: Mountain

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Placeholder background (no actual photo rendering)
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(.systemGray6), Color(.systemGray5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "mountain.2.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.secondary.opacity(0.5))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
                )

            Button {
                if let idx = mountain.photoFileNames.firstIndex(of: filename) {
                    mountain.photoFileNames.remove(at: idx)
                    ImageStore.deleteImage(named: filename)
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.6)))
            }
            .buttonStyle(.plain)
            .offset(x: 4, y: -4)
        }
    }
}
