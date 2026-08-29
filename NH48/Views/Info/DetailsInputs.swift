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
        VStack(alignment: .leading, spacing: 8) {
            Text("Details")
                .font(.footnote)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: "text.justify").foregroundStyle(.secondary)
                    Text("Description").font(.caption).foregroundStyle(.secondary)
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
            .padding(.vertical, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text("Latitude").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "location.north.line").foregroundStyle(.secondary)
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
            .padding(.vertical, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text("Longitude").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 10) {
                    Image(systemName: "location.north").foregroundStyle(.secondary)
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
            .padding(.vertical, 2)
        }
        .sectionCardStyle()
    }
}
