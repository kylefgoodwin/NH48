import SwiftUI

struct MountainInfoView: View {
    @Binding var mountain: Mountain

    var body: some View {
        VStack(spacing: 12) {
            LocationMapSection(mountain: $mountain)
            BasicInfoInputs(mountain: $mountain)
            DetailsInputs(mountain: $mountain)
        }
    }
}
