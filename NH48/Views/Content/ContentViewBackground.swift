import SwiftUI

struct ContentViewBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.blue.opacity(0.75), location: 0.0),
                    .init(color: Color.cyan.opacity(0.55), location: 0.45),
                    .init(color: Color.green.opacity(0.35), location: 1.0)
                ]),
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            RadialGradient(
                colors: [Color.white.opacity(0.18), Color.clear],
                center: .top,
                startRadius: 0,
                endRadius: 260
            )
            .blendMode(.overlay)
            
            Circle()
                .fill(Color.cyan.opacity(0.12))
                .frame(width: 176, height: 176)
                .offset(x: 150, y: 100)
                .blur(radius: 30)
            
            Circle()
                .fill(Color.blue.opacity(0.10))
                .frame(width: 88, height: 88)
                .offset(x: 120, y: 100)
                .blur(radius: 30)
            
            Circle()
                .fill(Color.green.opacity(0.08))
                .frame(width: 96, height: 96)
                .offset(x: 50, y: 40)
                .blur(radius: 30)
            
            LinearGradient(
                colors: [Color.black.opacity(0.15), Color.clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .blendMode(.softLight)
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(0.03)
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
}
