import SwiftUI

struct AddMountainView: View {
    @ObservedObject var store: MountainStore

    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var location: String = ""
    @State private var elevation: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Location", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Elevation", text: $elevation)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        let elevationInt = Int(elevation) ?? 0
                        let newMountain = Mountain(
                            name: name,
                            elevation: elevationInt,
                            location: location,
                            description: "",
                            latitude: nil,
                            longitude: nil,
                            isCompleted: false
                        )
                        store.mountains.append(newMountain)
                        dismiss()
                    }) {
                        Text("Save")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.headline)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Add a Mountain")
        }

    }
}
