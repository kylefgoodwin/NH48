import SwiftUI
import MapKit

struct MountainsMapView: View {
    let mountains: [Mountain]

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.16, longitude: -71.50),
        span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 1.2)
    )

    private var annotated: [(mountain: Mountain, coordinate: CLLocationCoordinate2D)] {
        mountains.compactMap { m in
            if let lat = m.latitude, let lon = m.longitude {
                return (m, CLLocationCoordinate2D(latitude: lat, longitude: lon))
            }
            return nil
        }
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
                Map(coordinateRegion: $region, annotationItems: annotated, annotationContent: { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        ZStack {
                            Circle()
                                .fill(item.mountain.isCompleted ? Color.green : Color.blue)
                                .frame(width: 12, height: 12)
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 12, height: 12)
                        }
                        .accessibilityLabel(item.mountain.name)
                    }
                })
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
