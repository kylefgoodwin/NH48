import SwiftUI

struct HikeStatsInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Distance (miles)").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "ruler").foregroundStyle(.secondary)
                    TextField("Distance (miles)", value: $mountain.distanceMiles, format: .number)
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
                    TextField("Elevation Gain (ft)", value: $mountain.elevationGain, format: .number)
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
                    TextField("Duration (minutes)", value: $mountain.durationMinutes, format: .number)
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
