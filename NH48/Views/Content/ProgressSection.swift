import SwiftUI

struct ProgressSection: View {
    let completedInt: Int
    let totalInt: Int
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Progress")
                    .font(.headline)

                Spacer()

                Text("\(completedInt)/\(totalInt)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: progress.isFinite ? progress : 0)
                .tint(.green)

            Text(String(format: "%.0f%% completed", progress.isFinite ? progress * 100 : 0))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal)
    }
}
