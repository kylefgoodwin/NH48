import SwiftUI

struct BasicInfoInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Basic Info")
                .font(.footnote)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 6) {
                Text("Name").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "textformat")
                        .foregroundStyle(.secondary)
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
            .padding(.vertical, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text("Location (range)").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "map")
                        .foregroundStyle(.secondary)
                    TextField("Location (range)", text: $mountain.location)
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
            .padding(.vertical, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text("Elevation (ft)").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "arrow.up.and.down")
                        .foregroundStyle(.secondary)
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
            .padding(.vertical, 2)
        }
        .sectionCardStyle()
    }
}
