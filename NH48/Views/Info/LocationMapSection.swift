import SwiftUI
import MapKit

struct LocationMapSection: View {
    @Binding var mountain: Mountain

    var body: some View {
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
    }
}
