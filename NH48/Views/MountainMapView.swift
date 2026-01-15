//
//  MountainMapView.swift
//  NH48
//
//  Created by Kyle Goodwin on 1/14/26.
//

import SwiftUI
import MapKit

struct MountainMapView: View {
    let mountain: Mountain

    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition) {
            if let lat = mountain.latitude, let lon = mountain.longitude {
                Annotation(mountain.name,
                           coordinate: CLLocationCoordinate2D(latitude: lat,
                                                              longitude: lon)) {
                    ZStack {
                        Circle().fill(.blue).frame(width: 14, height: 14)
                        Circle().stroke(.white, lineWidth: 2).frame(width: 14, height: 14)
                    }
                    .accessibilityLabel(mountain.name)
                }
            }
        }
        .onAppear {
            if let lat = mountain.latitude, let lon = mountain.longitude {
                let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let region = MKCoordinateRegion(center: coord,
                                                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                cameraPosition = .region(region)
            } else {
                // Fallback to a sensible default (center of New Hampshire)
                let fallback = CLLocationCoordinate2D(latitude: 43.1939, longitude: -71.5724)
                let region = MKCoordinateRegion(center: fallback,
                                                span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5))
                cameraPosition = .region(region)
            }
        }
        .navigationTitle(mountain.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

