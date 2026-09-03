import SwiftUI
import MapKit

struct LocationMapSection: View {
    @Binding var mountain: Mountain

    private var validCoordinate: CLLocationCoordinate2D? {
        guard let lat = mountain.latitude, let lon = mountain.longitude else { return nil }
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        guard CLLocationCoordinate2DIsValid(coord) && (lat != 0 || lon != 0) else { return nil }
        return coord
    }

    var body: some View {
        if let coordinate = validCoordinate {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "map.fill")
                        .foregroundColor(.blue)
                        .font(.headline)
                    Text("Map Location")
                        .font(.headline)
                        .foregroundColor(.primary)
                }

                Map(initialPosition: .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                ))) {
                    Annotation(mountain.name.isEmpty ? "Mountain" : mountain.name, coordinate: coordinate) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(width: 28, height: 28)
                                .blur(radius: 3)
                            Circle().fill(.blue).frame(width: 16, height: 16)
                            Circle().stroke(.white, lineWidth: 2.5).frame(width: 16, height: 16)
                        }
                    }
                }
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .sectionCardStyle()
        }
    }
}
