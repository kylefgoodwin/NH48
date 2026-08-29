import SwiftUI
import MapKit

struct MountainInfoView: View {
    @Binding var mountain: Mountain

    var body: some View {
        List {
            LocationMapSection(mountain: $mountain)
            BasicInfoInputs(mountain: $mountain)
            DetailsInputs(mountain: $mountain)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemGroupedBackground)], startPoint: .top, endPoint: .bottom)
        )
    }
}
