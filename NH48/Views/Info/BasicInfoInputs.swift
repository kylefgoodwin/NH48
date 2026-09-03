import SwiftUI

struct BasicInfoInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
                    .font(.headline)
                Text("Basic Info")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Name").font(.caption).bold().foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "textformat")
                        .foregroundStyle(.blue)
                    TextField("Name", text: $mountain.name)
                        .textInputAutocapitalization(.words)
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

            VStack(alignment: .leading, spacing: 6) {
                Text("Location (e.g. Range)").font(.caption).bold().foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "map")
                        .foregroundStyle(.purple)
                    TextField("Location (e.g. Range)", text: $mountain.location)
                        .textInputAutocapitalization(.words)
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

            VStack(alignment: .leading, spacing: 6) {
                Text("Elevation (ft)").font(.caption).bold().foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "arrow.up.and.down")
                        .foregroundStyle(.teal)
                    TextField("Elevation (ft)", value: $mountain.elevation, format: .number)
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
        }
        .sectionCardStyle()
    }
}
