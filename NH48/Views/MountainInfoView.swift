import SwiftUI
import MapKit

struct MountainInfoView: View {
    @Binding var mountain: Mountain

    var body: some View {
        List {
            // Map preview if coordinates available
            if let lat = mountain.latitude, let lon = mountain.longitude {
                Section(header: Text("Location").font(.footnote).foregroundColor(.secondary)) {
                    Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)))) {
                        Annotation(mountain.name.isEmpty ? "Mountain" : mountain.name,
                                   coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                            ZStack {
                                Circle().fill(.blue).frame(width: 12, height: 12)
                                Circle().stroke(.white, lineWidth: 2).frame(width: 12, height: 12)
                            }
                        }
                    }
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                }
                .sectionCardStyle()
            }

            // Editable fields
            Section(header: Text("Basic Info").font(.footnote).foregroundColor(.secondary)) {
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
                        TextField("Elevation (ft)", value: $mountain.elevation, formatter: NumberFormatter())
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
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemGroupedBackground)], startPoint: .top, endPoint: .bottom)
        )
    }
}

private struct SectionCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listRowBackground(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(colors: [Color(.secondarySystemBackground).opacity(0.9), Color(.systemBackground).opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            )
    }
}

private extension View {
    func sectionCardStyle() -> some View { modifier(SectionCardStyle()) }
}

private let decimalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 6
    return formatter
}()

// Helper to convert optional bindings to non-optional with a default value
private extension Binding {
    // Case 1: Binding to an optional value (Binding<Value?>)
    init(unwrapping source: Binding<Value?>, default defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in
                source.wrappedValue = newValue
            }
        )
    }

    // Case 2: Optional Binding to a non-optional value (Binding<Value>?)
    init(unwrapping source: Binding<Value>?, default defaultValue: Value) {
        self.init(
            get: { source?.wrappedValue ?? defaultValue },
            set: { newValue in
                source?.wrappedValue = newValue
            }
        )
    }

    // Case 3: Non-optional Binding provided; ignore default and forward through
    init(unwrapping source: Binding<Value>, default defaultValue: Value) {
        self = source
    }
}
