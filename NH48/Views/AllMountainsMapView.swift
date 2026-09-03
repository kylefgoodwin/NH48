import SwiftUI
import MapKit

struct AllMountainsMapView: View {
    let mountains: [Mountain]
    @EnvironmentObject var store: MountainStore
    @State private var selectedMountain: Mountain?
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                ForEach(mountains) { mountain in
                    if let lat = mountain.latitude, let lon = mountain.longitude {
                        Annotation(mountain.name, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                            Button(action: { selectedMountain = mountain }) {
                                Image(systemName: mountain.isCompleted ? "checkmark.circle.fill" : "mountain.2.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(mountain.isCompleted ? .green : .blue)
                                    .background(Circle().fill(.white))
                            }
                            .accessibilityLabel(mountain.name)
                        }
                    }
                }
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedMountain) { mountain in
                NavigationStack {
                    MountainDetailView(mountain: mountain) { updated in
                        store.updateMountain(updated)
                    }
                }
            }
        }
    }
}

#Preview {
    AllMountainsMapView(mountains: [])
        .environmentObject(MountainStore())
}
