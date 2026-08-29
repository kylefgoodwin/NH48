import SwiftUI

struct DetailsInputs: View {
    @Binding var mountain: Mountain

    var body: some View {
        Section(header: Text("Details").font(.footnote).foregroundColor(.secondary)) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: "text.justify").foregroundStyle(.secondary)
                    Text("Description").font(.caption).foregroundStyle(.secondary)
                }
                TextEditor(text: Binding<String>(unwrapping: $mountain.description, default: ""))
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
                    TextField("Latitude", value: Binding<Double>(unwrapping: $mountain.latitude, default: 0.0), formatter: decimalFormatter)
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
                    TextField("Longitude", value: Binding<Double>(unwrapping: $mountain.longitude, default: 0.0), formatter: decimalFormatter)
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
