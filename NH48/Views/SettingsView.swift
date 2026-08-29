import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultSortOption") private var defaultSortOptionRaw: String = SortOption.elevationDescending.rawValue
    @AppStorage("useMetricUnits") private var useMetricUnits: Bool = false

    var body: some View {
        Form {
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
