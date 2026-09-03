import SwiftUI

struct DashboardHeader: View {
    let completed: Int
    let total: Int
    let progress: Double
    let greeting: String
    let motivation: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("NH 4,000-FOOTERS")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .tracking(2.0)
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(greeting)
                    .font(.system(.title, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                
                Text(motivation)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(2)
            }
            
            Spacer()
            
            // Visual circular progress ring
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.18), lineWidth: 8)
                    .frame(width: 72, height: 72)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(
                        LinearGradient(colors: [.green, .mint], startPoint: .top, endPoint: .bottom),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 72, height: 72)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeOut, value: progress)
                
                VStack(spacing: 0) {
                    Text(String(format: "%.0f%%", progress * 100))
                        .font(.system(.subheadline, design: .rounded).weight(.bold))
                        .foregroundStyle(.white)
                    Text("\(completed)/\(total)")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.7))
                }
            }
        }
    }
}
