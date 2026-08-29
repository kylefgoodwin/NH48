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
                    .foregroundStyle(.white)
                Spacer()
                Text("\(completedInt)/\(totalInt)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.9))
            }
            
            ProgressView(value: progress)
                .tint(.white)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .shadow(radius: 1)
            
            Text(String(format: "%.0f%% completed", progress.isFinite ? progress * 100 : 0))
                .font(.caption)
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.15), lineWidth: 0.5)
        )
        .padding(.horizontal)
    }
}
