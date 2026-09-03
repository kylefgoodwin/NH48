import SwiftUI

struct AddMountainView: View {
    @ObservedObject var store: MountainStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var location = ""
    @State private var elevation = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Mountain Details") {
                    TextField("Name", text: $name)
                    TextField("Location (e.g. Range)", text: $location)
                    TextField("Elevation (ft)", text: $elevation)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add a Mountain")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let elevationInt = Int(elevation) ?? 0
                        let newMountain = Mountain(
                            name: name,
                            elevation: elevationInt,
                            location: location,
                            description: "",
                            latitude: nil,
                            longitude: nil,
                            isCompleted: false,
                            image: nil,
                            personalNotes: nil,
                            completionDate: nil,
                            rating: nil,
                            difficulty: nil,
                            conditions: nil,
                            distanceMiles: nil,
                            elevationGain: nil,
                            durationMinutes: nil,
                            tags: [],
                            photoFileNames: []
                        )
                        store.mountains.append(newMountain)
                        store.saveData()
                        dismiss()
                    }
                    .disabled(name.isEmpty || location.isEmpty || elevation.isEmpty)
                }
            }
        }
    }
}
