import SwiftUI
import MapKit

struct MountainsMapView: View {
    let mountains: [Mountain]

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.16, longitude: -71.50),
        span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 1.2)
    )

    private var annotated: [Mountain] {
        mountains.filter { $0.latitude != nil && $0.longitude != nil }
    }

    var body: some View {
        Group {
            if annotated.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "map")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No coordinates to display")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            } else {
                Map(initialPosition: .region(region)) {
                    ForEach(annotated) { m in
                        let coord = CLLocationCoordinate2D(latitude: m.latitude!, longitude: m.longitude!)
                        Annotation(m.name, coordinate: coord) {
                            ZStack {
                                Circle()
                                    .fill(m.isCompleted ? Color.green : Color.blue)
                                    .frame(width: 12, height: 12)
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 12, height: 12)
                            }
                            .accessibilityLabel(m.name)
                        }
                    }
                }
                .mapStyle(.standard)
            }
        }
        .navigationTitle("Mountains Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
    }
}

#Preview {
    MountainsMapView(mountains: [])
}
