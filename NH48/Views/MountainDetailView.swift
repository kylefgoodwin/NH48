//
//  MountainDetailView.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//


// MountainDetailView.swift
import SwiftUI

struct MountainDetailView: View {
    var mountain: Mountain
    var onUpdate: (Mountain) -> Void

    @State private var editableMountain: Mountain

    init(mountain: Mountain, onUpdate: @escaping (Mountain) -> Void) {
        self.mountain = mountain
        self.onUpdate = onUpdate
        _editableMountain = State(initialValue: mountain)
    }

    var body: some View {
        Form {
            Section(header: Text("Basic Info")) {
                TextField("Name", text: $editableMountain.name)
                TextField("Location", text: $editableMountain.location)
                TextField("Elevation", value: $editableMountain.elevation, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Details")) {
                TextField("Description", text: Binding($editableMountain.description, defaultValue: ""))
                TextField("Latitude", value: Binding($editableMountain.latitude, defaultValue: 0.0), formatter: decimalFormatter)
                    .keyboardType(.decimalPad)
                TextField("Longitude", value: Binding($editableMountain.longitude, defaultValue: 0.0), formatter: decimalFormatter)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Toggle("Completed", isOn: $editableMountain.isCompleted)
            }
            
            Section {
                Button("Save") {
                    onUpdate(editableMountain)
                }
            }
        }
        .navigationTitle(editableMountain.name)
    }
}

// Helper to provide a default binding for optionals
extension Binding {
    init(_ source: Binding<Value?>, defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}

private let decimalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 6 // or however many you want for lat/long
    return formatter
}()
