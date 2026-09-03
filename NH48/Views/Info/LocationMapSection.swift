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
            VStack(alignment: .leading, spacing: 12) {
                Text("Map Location")
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.leading, 8)

                Map(initialPosition: .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                ))) {
                    Annotation(mountain.name.isEmpty ? "Mountain" : mountain.name, coordinate: coordinate) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(width: 32, height: 32)
                                .blur(radius: 4)
                                .offset(y: 2)
                            Circle().fill(.blue).frame(width: 18, height: 18)
                            Circle().stroke(.white, lineWidth: 3).frame(width: 18, height: 18)
                        }
                        .shadow(color: Color.blue.opacity(0.33), radius: 8, y: 2)
                    }
                }
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .shadow(color: Color.black.opacity(0.10), radius: 18, x: 0, y: 10)
            )
            .padding(.vertical, 10)
        }
    }
}
