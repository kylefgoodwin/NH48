import SwiftUI

struct HikeStatsInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Distance (miles)").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "ruler").foregroundStyle(.secondary)
                    TextField("Distance (miles)", value: Binding<Double>(unwrapping: $mountain.distanceMiles, default: 0.0), formatter: decimalFormatter)
                        .keyboardType(.decimalPad)
                        .font(.body.monospacedDigit())
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                )
            }
            .padding(.vertical, 2)
            VStack(alignment: .leading, spacing: 6) {
                Text("Elevation Gain (ft)").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "arrow.up").foregroundStyle(.secondary)
                    TextField("Elevation Gain (ft)", value: Binding<Int>(unwrapping: $mountain.elevationGain, default: 0), formatter: integerFormatter)
                        .keyboardType(.numberPad)
                        .font(.body.monospacedDigit())
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                )
            }
            .padding(.vertical, 2)
            VStack(alignment: .leading, spacing: 6) {
                Text("Duration (minutes)").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "clock").foregroundStyle(.secondary)
                    TextField("Duration (minutes)", value: Binding<Int>(unwrapping: $mountain.durationMinutes, default: 0), formatter: integerFormatter)
                        .keyboardType(.numberPad)
                        .font(.body.monospacedDigit())
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                )
            }
            .padding(.vertical, 2)
        }
    }
}
