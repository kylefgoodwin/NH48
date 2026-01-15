import SwiftUI
import MapKit

struct AllMountainsMapView: View {
    let mountains: [Mountain]
    @EnvironmentObject private var store: MountainStore
    @State private var selectedMountain: Mountain?
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(mountains) { mountain in
                if let lat = mountain.latitude, let lon = mountain.longitude {
                    Annotation(mountain.name,
                               coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                        Button(action: { selectedMountain = mountain }) {
                            ZStack {
                                Circle().fill(.blue).frame(width: 12, height: 12)
                                Circle().stroke(.white, lineWidth: 2).frame(width: 12, height: 12)
                            }
                        }
                        .accessibilityLabel(mountain.name)
                    }
                }
            }
        }
        .onAppear {
            // Compute a region that encompasses all valid mountain coordinates, or fallback to NH center
            let coords = mountains.compactMap { m -> CLLocationCoordinate2D? in
                if let lat = m.latitude, let lon = m.longitude { return CLLocationCoordinate2D(latitude: lat, longitude: lon) }
                return nil
            }
            if let region = regionThatFits(coordinates: coords) {
                cameraPosition = .region(region)
            } else {
                let fallback = CLLocationCoordinate2D(latitude: 43.1939, longitude: -71.5724)
                let region = MKCoordinateRegion(center: fallback,
                                                span: MKCoordinateSpan(latitudeDelta: 2.5, longitudeDelta: 2.5))
                cameraPosition = .region(region)
            }
        }
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedMountain) { mountain in
            NavigationStack {
                MountainDetailView(mountain: mountain) { updated in
                    if let index = store.mountains.firstIndex(where: { $0.id == updated.id }) {
                        store.mountains[index] = updated
                        store.saveData()
                    }
                }
            }
        }
    }

    private func regionThatFits(coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion? {
        guard !coordinates.isEmpty else { return nil }
        var minLat = coordinates.first!.latitude
        var maxLat = coordinates.first!.latitude
        var minLon = coordinates.first!.longitude
        var maxLon = coordinates.first!.longitude
        for c in coordinates.dropFirst() {
            minLat = min(minLat, c.latitude)
            maxLat = max(maxLat, c.latitude)
            minLon = min(minLon, c.longitude)
            maxLon = max(maxLon, c.longitude)
        }
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2.0,
                                            longitude: (minLon + maxLon) / 2.0)
        // Add padding to span
        let latDelta = max(0.1, (maxLat - minLat) * 1.3)
        let lonDelta = max(0.1, (maxLon - minLon) * 1.3)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        return MKCoordinateRegion(center: center, span: span)
    }
}

#Preview {
    AllMountainsMapView(mountains: [])
}
