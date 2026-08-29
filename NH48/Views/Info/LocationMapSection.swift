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
                Text("Location")
                    .font(.footnote)
                    .foregroundColor(.secondary)

                Map(initialPosition: .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                ))) {
                    Annotation(mountain.name.isEmpty ? "Mountain" : mountain.name, coordinate: coordinate) {
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
    }
}
