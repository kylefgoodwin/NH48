import SwiftUI

struct DetailBackgroundView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            GeometryReader { geo in
                Circle()
                    .fill(Color.blue.opacity(0.12))
                    .blur(radius: 70)
                    .frame(width: geo.size.width * 0.8)
                    .offset(x: -geo.size.width * 0.2, y: -100)

                Circle()
                    .fill(Color.purple.opacity(0.09))
                    .blur(radius: 80)
                    .frame(width: geo.size.width * 0.3)
                    .offset(y: geo.size.height * 0.4)
            }
            .ignoresSafeArea()
        }
    }
}
