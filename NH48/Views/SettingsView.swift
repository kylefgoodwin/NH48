import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultSortOption") private var defaultSortOptionRaw: String = ContentView.SortOption.elevationDescending.rawValue
    @AppStorage("useMetricUnits") private var useMetricUnits: Bool = false

    private var selectedSortOption: Binding<ContentView.SortOption> {
        Binding<ContentView.SortOption>(
            get: {
                ContentView.SortOption(rawValue: defaultSortOptionRaw) ?? .elevationDescending
            },
            set: {
                defaultSortOptionRaw = $0.rawValue
            }
        )
    }

    var body: some View {
        Form {
            Section(header: Text("Default Sort")) {
                Picker("Sort", selection: selectedSortOption) {
                    ForEach(ContentView.SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.inline)
            }

            Section(header: Text("Units")) {
                Toggle(isOn: $useMetricUnits) {
                    Text("Use metric units (meters, kilometers)")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { SettingsView() }
}
