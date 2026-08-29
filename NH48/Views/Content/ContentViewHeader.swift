import SwiftUI

struct ContentViewHeader: View {
    @Binding var selectedFilter: MountainFilter
    @Binding var selectedRange: String?
    @Binding var sortOption: SortOption
    var uniqueRanges: [String]
    
    var onAddTap: () -> Void

    var body: some View {
        HStack {
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.25), lineWidth: 1))
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
            }
            .accessibilityLabel("Settings")
            
            Spacer()
            
            Text("NH48")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: onAddTap) {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.25), lineWidth: 1))
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
            }
            .accessibilityLabel("Add Mountain")
        }
    }
}
