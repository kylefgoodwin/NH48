import SwiftUI

struct DetailsInputs: View {
    @Binding var mountain: Mountain

    private var descriptionBinding: Binding<String> {
        Binding(
            get: { mountain.description ?? "" },
            set: { mountain.description = $0.isEmpty ? nil : $0 }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "doc.text.fill")
                    .foregroundColor(.indigo)
                    .font(.headline)
                Text("Details")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            // Description Area
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: "text.justify").foregroundStyle(.indigo)
                    Text("Description").font(.caption).bold().foregroundStyle(.secondary)
                }
                TextEditor(text: descriptionBinding)
                    .frame(minHeight: 100)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
            }

            // Side-by-Side Coordinates Grid
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
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
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
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                }
            }
        }
        .sectionCardStyle()
    }
}
