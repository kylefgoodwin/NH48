import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: MountainStore
    @State private var searchText: String = ""
    @State private var selectedFilter: MountainFilter = .all
    @State private var selectedRange: String? = nil
    @State private var sortOption: SortOption = .elevationDescending
    @State private var showAddMountainSheet: Bool = false

    // Unique ranges mapped with peak counts for the horizontal carousel
    private var rangesWithCounts: [(name: String, count: Int)] {
        let ranges = store.mountains.map { $0.location }
        let grouped = Dictionary(grouping: ranges, by: { $0 }).mapValues { $0.count }
        return grouped.map { (name: $0.key, count: $0.value) }.sorted { $0.name < $1.name }
    }

    private var filteredMountains: [Mountain] {
        var result = store.mountains
        
        // Filter by search
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let query = searchText.lowercased()
            result = result.filter { $0.name.lowercased().contains(query) || $0.location.lowercased().contains(query) }
        }
        
        // Filter by completion
        switch selectedFilter {
        case .all: break
        case .completed: result = result.filter { $0.isCompleted }
        case .notCompleted: result = result.filter { !$0.isCompleted }
        case .range:
            if let selectedRange { result = result.filter { $0.location == selectedRange } }
        }
        
        // Sort
        switch sortOption {
        case .elevationDescending:
            result.sort { $0.elevation > $1.elevation }
        case .elevationAscending:
            result.sort { $0.elevation < $1.elevation }
        case .name:
            result.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .completedFirst:
            result.sort {
                if $0.isCompleted != $1.isCompleted {
                    return $0.isCompleted && !$1.isCompleted
                }
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        }
        return result
    }

    private var progressTuple: (completed: Int, total: Int, progress: Double) {
        let completed = store.mountains.filter { $0.isCompleted }.count
        let total = store.mountains.count
        let progress = total > 0 ? Double(completed) / Double(total) : 0
        return (completed, total, progress)
    }

    private let columns = [
        GridItem(.adaptive(minimum: 160, maximum: 220), spacing: 14, alignment: .top)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                ContentViewBackground()
                
                ScrollView {
                    VStack(spacing: 18) {
                        DashboardHeader(
                            completed: progressTuple.completed,
                            total: progressTuple.total,
                            progress: progressTuple.progress,
                            greeting: greetingMessage,
                            motivation: motivationalMessage
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 10)

                        HistoryAndChartCard(store: store)

                        SearchBar(
                            searchText: $searchText,
                            sortOption: $sortOption,
                            selectedFilter: $selectedFilter,
                            selectedRange: $selectedRange,
                            uniqueRanges: rangesWithCounts.map { $0.name }
                        )

                        RangeCarousel(
                            rangesWithCounts: rangesWithCounts,
                            selectedFilter: $selectedFilter,
                            selectedRange: $selectedRange
                        )

                        GridHeaderSection(
                            title: gridSectionTitle,
                            count: filteredMountains.count
                        )

                        MountainGrid(
                            filteredMountains: filteredMountains,
                            columns: columns,
                            store: store
                        )
                    }
                }
            }
            .navigationDestination(for: Mountain.self) { mountain in
                MountainDetailView(mountain: mountain) { updatedMountain in
                    store.updateMountain(updatedMountain)
                }
            }
            .navigationTitle("NH48")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddMountainSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                }
            }
            .sheet(isPresented: $showAddMountainSheet) {
                AddMountainView(store: store)
            }
        }
    }

    // Dynamic UI copy helpers
    private var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good Morning!" }
        if hour < 18 { return "Good Afternoon!" }
        return "Good Evening!"
    }

    private var motivationalMessage: String {
        let left = progressTuple.total - progressTuple.completed
        if left == 0 {
            return "Incredible job! You've conquered all NH48 peaks!"
        } else if progressTuple.completed > 0 {
            return "You've hiked \(progressTuple.completed) peaks. Just \(left) more to go!"
        } else {
            return "Ready to conquer your first 4,000-footer?"
        }
    }

    private var gridSectionTitle: String {
        if let selectedRange {
            return selectedRange
        }
        switch selectedFilter {
        case .all: return "All Peaks"
        case .completed: return "Conquered Peaks"
        case .notCompleted: return "Pending Climbs"
        case .range: return "Range Filtered"
        }
    }
}

#Preview {
    let store = MountainStore()
    return HomeView()
        .environmentObject(store)
}
