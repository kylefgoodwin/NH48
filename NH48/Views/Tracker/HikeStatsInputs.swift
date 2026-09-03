import SwiftUI

struct HikeStatsInputs: View {
    @Binding var mountain: Mountain

    private var averagePace: String? {
        guard let miles = mountain.distanceMiles, miles > 0,
              let minutes = mountain.durationMinutes, minutes > 0 else { return nil }
        let pace = Double(minutes) / miles
        return String(format: "%.1f min/mi", pace)
    }

    var body: some View {
        let columns: [GridItem] = [
            GridItem(.flexible(minimum: 180), spacing: 12, alignment: .top),
            GridItem(.flexible(minimum: 180), spacing: 12, alignment: .top)
        ]

        LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
            EditableStatBox(icon: "ruler", label: "Distance", value: Binding(
                get: { mountain.distanceMiles?.formatted() ?? "" },
                set: {
                    if let val = Double($0), val >= 0 {
                        mountain.distanceMiles = val
                    } else if $0.isEmpty {
                        mountain.distanceMiles = nil
                    }
                }),
                            suffix: "mi", color: .blue).frame(maxWidth: .infinity)

            EditableStatBox(icon: "arrow.up.forward", label: "Elevation Gain", value: Binding(
                get: { mountain.elevationGain?.formatted() ?? "" },
                set: {
                    if let val = Int($0), val >= 0 {
                        mountain.elevationGain = val
                    } else if $0.isEmpty {
                        mountain.elevationGain = nil
                    }
                }),
                            suffix: "ft", color: .purple).frame(maxWidth: .infinity)

            EditableStatBox(icon: "clock", label: "Duration", value: Binding(
                get: { mountain.durationMinutes?.formatted() ?? "" },
                set: {
                    if let val = Int($0), val >= 0 {
                        mountain.durationMinutes = val
                    } else if $0.isEmpty {
                        mountain.durationMinutes = nil
                    }
                }),
                            suffix: "min", color: .orange).frame(maxWidth: .infinity)

            if let pace = averagePace {
                CompactStatBox(icon: "stopwatch", label: "Avg Pace", value: pace, suffix: "", color: .green).frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 6)
    }
}

struct EditableStatBox: View {
    let icon: String
    let label: String
    @Binding var value: String
    let suffix: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(color)
                    .frame(width: 22, alignment: .center)
                TextField("", text: $value)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 60, maxWidth: 100, alignment: .leading)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.primary)
                    .layoutPriority(1)
                if !suffix.isEmpty {
                    Text(suffix)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                        .layoutPriority(2)
                }
            }
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: color.opacity(0.10), radius: 6, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.gradient.opacity(0.18), lineWidth: 1.5)
        )
    }
}

struct CompactStatBox: View {
    let icon: String
    let label: String
    let value: String
    let suffix: String
    let color: Color

    var body: some View {
        VStack(spacing: 3) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(color)
                    .frame(width: 20, alignment: .center)
                Text(value)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                if !suffix.isEmpty {
                    Text(suffix)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: color.opacity(0.10), radius: 6, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.gradient.opacity(0.18), lineWidth: 1.5)
        )
    }
}

