import SwiftUI

struct AddMountainView: View {
    @ObservedObject var store: MountainStore
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var location: String = ""
    @State private var elevation: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Mountain Details")) {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                    
                    TextField("Location (e.g. Range)", text: $location)
                        .textInputAutocapitalization(.words)
                    
                    TextField("Elevation (ft)", text: $elevation)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add a Mountain")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let elevationInt = Int(elevation) ?? 0
                        let newMountain = Mountain(
                            name: name,
                            elevation: elevationInt,
                            location: location,
                            isCompleted: false
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
