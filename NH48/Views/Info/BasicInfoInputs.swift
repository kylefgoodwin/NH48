import SwiftUI

struct BasicInfoInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 28, height: 28)
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .bold))
                }
                Text("Basic Info")
                    .font(.system(.headline, design: .rounded, weight: .bold))
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
                        .stroke(Color.blue.opacity(0.12), lineWidth: 1)
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
                        .stroke(Color.purple.opacity(0.12), lineWidth: 1)
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
                        .stroke(Color.teal.opacity(0.12), lineWidth: 1)
                )
            }

            // Latitude & Longitude
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Latitude").font(.caption).bold().foregroundStyle(.secondary)
                    HStack(spacing: 8) {
                        Image(systemName: "location.north.line").foregroundStyle(.indigo)
                        TextField("Latitude", value: $mountain.latitude, format: .number)
                            .keyboardType(.decimalPad)
                            .font(.body.monospacedDigit())
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.indigo.opacity(0.12), lineWidth: 1)
                    )
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Longitude").font(.caption).bold().foregroundStyle(.secondary)
                    HStack(spacing: 8) {
                        Image(systemName: "location.north").foregroundStyle(.indigo)
                        TextField("Longitude", value: $mountain.longitude, format: .number)
                            .keyboardType(.decimalPad)
                            .font(.body.monospacedDigit())
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.indigo.opacity(0.12), lineWidth: 1)
                    )
                }
            }
        }
        .sectionCardStyle()
    }
}
