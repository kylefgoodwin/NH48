import SwiftUI

struct RootView: View {
    @StateObject private var store = MountainStore()

    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Label("List", systemImage: "list.bullet")
            }

            NavigationStack {
                AllMountainsMapView(mountains: store.mountains)
                    .navigationTitle("Map")
                    .navigationBarTitleDisplayMode(.inline)
            }
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
