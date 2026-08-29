import SwiftUI
import MapKit

struct MountainInfoView: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(spacing: 16) {
            LocationMapSection(mountain: $mountain)
            BasicInfoInputs(mountain: $mountain)
            DetailsInputs(mountain: $mountain)
        }
    }
}
