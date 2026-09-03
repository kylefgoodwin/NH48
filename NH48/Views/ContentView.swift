import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: MountainStore
    @State private var searchText = ""
    @State private var selectedFilter: MountainFilter = .all
    @State private var selectedRange: String? = nil
    @State private var sortOption: SortOption = .elevationDescending
    @State private var showAddMountainSheet = false
    
    @AppStorage("defaultSortOption") private var defaultSortOptionRaw: String = SortOption.elevationDescending.rawValue
    
    private func uniqueRanges(from mountains: [Mountain]) -> [String] {
        Array(Set(mountains.map { $0.location })).sorted()
    }

    var completedCount: Int {
        store.mountains.filter(\.isCompleted).count
    }

    var totalCount: Int {
        store.mountains.count
    }

    var progressRatio: Double {
        totalCount > 0 ? Double(completedCount) / Double(totalCount) : 0
    }
    
    var filteredMountains: [Mountain] {
        let filtered = store.mountains.filter { mountain in
            switch selectedFilter {
            case .all:
                return true
            case .completed:
                return mountain.isCompleted
            case .notCompleted:
                return !mountain.isCompleted
            case .range:
                if let selectedRange { return mountain.location == selectedRange }
                return true
            }
        }

        let searched: [Mountain]
        if searchText.isEmpty {
            searched = filtered
        } else {
            searched = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.location.localizedCaseInsensitiveContains(searchText)
            }
        }

        return searched.sorted(by: mountainSortComparator)
    }

    private func mountainSortComparator(_ lhs: Mountain, _ rhs: Mountain) -> Bool {
        switch sortOption {
        case .elevationDescending:
            return lhs.elevation > rhs.elevation
        case .elevationAscending:
            return lhs.elevation < rhs.elevation
        case .name:
            return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
        case .completedFirst:
            if lhs.isCompleted != rhs.isCompleted {
                return lhs.isCompleted && !rhs.isCompleted
            }
            return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ContentViewBackground()

                ScrollView {
                    VStack(spacing: 16) {
                        ContentViewHeader(onAddTap: { showAddMountainSheet = true })
                            .padding(.horizontal)

                        SearchBar(
                            searchText: $searchText,
                            sortOption: $sortOption,
                            selectedFilter: $selectedFilter,
                            selectedRange: $selectedRange,
                            uniqueRanges: uniqueRanges(from: store.mountains)
                        )

                        ProgressSection(
                            completedInt: completedCount,
                            totalInt: totalCount,
                            progress: progressRatio
                        )

                        CompletionChart(store: store)

                        MountainsList(
                            filteredMountains: filteredMountains,
                            store: store
                        )
                    }
                    .padding(.vertical)
                }
            }
            .sheet(isPresented: $showAddMountainSheet) {
                AddMountainView(store: store)
            }
            .onAppear {
                if let restored = SortOption.allCases.first(where: { $0.rawValue == defaultSortOptionRaw }) {
                    sortOption = restored
                }
            }
            .onChange(of: sortOption) { _, newValue in
                defaultSortOptionRaw = newValue.rawValue
            }
            .onChange(of: selectedFilter) { _, newValue in
                if newValue == .range, selectedRange == nil {
                    selectedRange = uniqueRanges(from: store.mountains).first
                }
            }
        }
    }
}
