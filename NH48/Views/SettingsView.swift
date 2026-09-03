import SwiftUI

struct SettingsView: View {
    @AppStorage("useMetricUnits") private var useMetricUnits: Bool = false

    var body: some View {
        Form {
            Section("Units") {
                Toggle("Use metric units (meters, kilometers)", isOn: $useMetricUnits)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { SettingsView() }
}
