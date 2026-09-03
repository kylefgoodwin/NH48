import SwiftUI

struct HikeStatsInputs: View {
    @Binding var mountain: Mountain

    private var averagePace: String? {
        guard let miles = mountain.distanceMiles, miles > 0,
              let minutes = mountain.durationMinutes, minutes > 0 else { return nil }
        let pace = Double(minutes) / miles
        return String(format: "%.1f", pace)
    }

    var body: some View {
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]

        LazyVGrid(columns: columns, spacing: 10) {
            EditableStatCard(
                icon: "ruler",
                label: "Distance",
                value: Binding(
                    get: { mountain.distanceMiles?.formatted() ?? "" },
                    set: {
                        if let val = Double($0), val >= 0 {
                            mountain.distanceMiles = val
                        } else if $0.isEmpty {
                            mountain.distanceMiles = nil
                        }
                    }
                ),
                suffix: "mi",
                color: .blue
            )

            EditableStatCard(
                icon: "arrow.up.forward.app.fill",
                label: "Elevation Gain",
                value: Binding(
                    get: { mountain.elevationGain?.formatted() ?? "" },
                    set: {
                        if let val = Int($0), val >= 0 {
                            mountain.elevationGain = val
                        } else if $0.isEmpty {
                            mountain.elevationGain = nil
                        }
                    }
                ),
                suffix: "ft",
                color: .purple
            )

            EditableStatCard(
                icon: "clock.fill",
                label: "Duration",
                value: Binding(
                    get: { mountain.durationMinutes?.formatted() ?? "" },
                    set: {
                        if let val = Int($0), val >= 0 {
                            mountain.durationMinutes = val
                        } else if $0.isEmpty {
                            mountain.durationMinutes = nil
                        }
                    }
                ),
                suffix: "min",
                color: .orange
            )

            if let pace = averagePace {
                ReadOnlyStatCard(
                    icon: "stopwatch.fill",
                    label: "Avg Pace",
                    value: pace,
                    suffix: "min/mi",
                    color: .green
                )
            }
        }
    }
}
