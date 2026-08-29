import SwiftUI

struct ContentViewHeader: View {
    var body: some View {
        HStack {
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                    .padding(8)
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
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}
