import SwiftUI
import Charts

struct CompletionChart: View {
    let store: MountainStore
    
    private var chartPoints: [(Date, Int)] {
        let completions = store.mountains.compactMap { mountain in
            mountain.completionDate.map { Calendar.current.startOfDay(for: $0) }
        }
        guard !completions.isEmpty else { return [] }
        
        let dayCounts = Dictionary(grouping: completions, by: { $0 })
        let days = dayCounts.keys.sorted()
        var running = 0
        
        var points: [(Date, Int)] = days.map { day in
            running += dayCounts[day]?.count ?? 0
            return (day, running)
        }
        
        // Insert a starting baseline point 1 day before the first completion to make the chart display nicely from 0 progress.
        if let firstPoint = points.first {
            let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: firstPoint.0) ?? firstPoint.0.addingTimeInterval(-86400)
            points.insert((dayBefore, 0), at: 0)
        }
        return points
    }
    
    var body: some View {
        if chartPoints.isEmpty {
            EmptyView()
        } else {
            Chart {
                ForEach(chartPoints, id: \.0) { (day, count) in
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
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.day().month(.abbreviated))
                }
            }
            .frame(height: 120)
            .padding(.horizontal)
        }
    }
}
