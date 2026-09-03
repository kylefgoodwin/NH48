import SwiftUI

struct RootView: View {
    @StateObject private var store = MountainStore()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }

            AllMountainsMapView(mountains: store.mountains)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
        .environmentObject(store)
    }
}

#Preview {
    RootView()
}
