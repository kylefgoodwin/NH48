import SwiftUI
import Charts

struct CompletionChart: View {
    let store: MountainStore
    
    var body: some View {
        if store.mountains.contains(where: { $0.completionDate != nil }) {
            let dayCounts = Dictionary(grouping: store.mountains.compactMap { mountain in
                mountain.completionDate.map { Calendar.current.startOfDay(for: $0) }
            }) { $0 }
            let days = dayCounts.keys.sorted()
            var running = 0
            let points: [(Date, Int)] = days.map { day in
                running += dayCounts[day]?.count ?? 0
                return (day, running)
            }
            
            Chart {
                ForEach(points, id: \.0) { (day, count) in
                    AreaMark(x: .value("Date", day), y: .value("Completed", count))
                        .foregroundStyle(
                            .linearGradient(
                                colors: [Color.white.opacity(0.25), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    LineMark(x: .value("Date", day), y: .value("Completed", count))
                        .foregroundStyle(.white)
                }
            }
            .chartXAxis { AxisMarks(values: .automatic(desiredCount: 4)) }
            .frame(height: 120)
            .padding(.horizontal)
        }
    }
}
