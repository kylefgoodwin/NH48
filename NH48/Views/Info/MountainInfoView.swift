import SwiftUI

struct MountainInfoView: View {
    @Binding var mountain: Mountain

    var body: some View {
        LocationMapSection(mountain: $mountain)
        BasicInfoInputs(mountain: $mountain)
        DetailsInputs(mountain: $mountain)
    }
}
