import SwiftUI

struct MountainDetailHeaderView: View {
    @Binding var mountain: Mountain
    
    private var statusChip: some View {
        HStack(spacing: 8) {
            Image(systemName: mountain.isCompleted ? "checkmark.circle.fill" : "circle.dashed")
                .font(.subheadline.weight(.bold))

            Text(statusText)
                .font(.subheadline.weight(.semibold))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            mountain.isCompleted.toggle()
            mountain.completionDate = mountain.isCompleted ? Date() : nil
        }
        .foregroundColor(mountain.isCompleted ? Color(red: 0.15, green: 0.68, blue: 0.38) : .orange)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(mountain.isCompleted ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
        )
        .padding(.top, 4)
    }
    
    private var statusText: String {
        if mountain.isCompleted {
            if let date = mountain.completionDate {
                return "Completed on \(date.formatted(date: .abbreviated, time: .omitted))"
            } else {
                return "Completed"
            }
        } else {
            return "To Do"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(mountain.location.uppercased())
                .font(.caption.bold())
                .tracking(1.5)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)

            Text(mountain.name)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
                .multilineTextAlignment(.leading)

            statusChip
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.4), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
        )
    }
}
