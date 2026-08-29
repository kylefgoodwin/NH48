import SwiftUI

// MARK: - Enums for Filtering and Sorting
enum MountainFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case completed = "Completed"
    case notCompleted = "Not Completed"
    case range = "Mountain Range"
    
    var id: String { rawValue }
}

enum SortOption: String, CaseIterable, Identifiable {
    case elevationDescending = "Elevation ↓"
    case elevationAscending = "Elevation ↑"
    case name = "Name"
    case completedFirst = "Completed"
    
    var id: String { rawValue }
}

struct ContentView: View {
    @StateObject private var store = MountainStore()
    @State private var searchText = ""
    @State private var showAddMountainSheet = false
    @State private var selectedRange: String? = nil
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @AppStorage("defaultSortOption") private var defaultSortOptionRaw: String = SortOption.elevationDescending.rawValue
    
    var uniqueRanges: [String] {
        Array(Set(store.mountains.map { $0.location })).sorted()
    }
    
    @State private var selectedFilter: MountainFilter = .all
    @State private var sortOption: SortOption = .elevationDescending
    
    private struct ProgressInfo { let completedInt: Int; let totalInt: Int; let progress: Double }
    
    private func makeProgressInfo(from mountains: [Mountain]) -> ProgressInfo {
        let completedInt: Int = mountains.reduce(0) { $0 + ($1.isCompleted ? 1 : 0) }
        let totalInt: Int = mountains.count
        let progress: Double = totalInt > 0 ? Double(completedInt) / Double(totalInt) : 0
        return ProgressInfo(completedInt: completedInt, totalInt: totalInt, progress: progress)
    }
    
    var filteredMountains: [Mountain] {
        let baseList: [Mountain] = store.mountains.filter { mountain in
            switch selectedFilter {
            case .all:
                return true
            case .completed:
                return mountain.isCompleted
            case .notCompleted:
                return !mountain.isCompleted
            case .range:
                if let selectedRange = selectedRange {
                    return mountain.location == selectedRange
                }
                return true
            }
        }

        let searched: [Mountain]
        if searchText.isEmpty {
            searched = baseList
        } else {
            let needle = searchText.lowercased()
            searched = baseList.filter { $0.name.lowercased().contains(needle) }
        }

        let sorted: [Mountain] = searched.sorted(by: mountainSortComparator)
        return sorted
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
    
    private struct MainContent: View {
        @Binding var selectedFilter: MountainFilter
        @Binding var selectedRange: String?
        @Binding var sortOption: SortOption
        @Binding var searchText: String
        let uniqueRanges: [String]
        let progressInfo: ProgressInfo
        @ObservedObject var store: MountainStore
        var onAddTap: () -> Void

        var body: some View {
            VStack(spacing: 16) {
                ContentViewHeader(
                    selectedFilter: $selectedFilter,
                    selectedRange: $selectedRange,
                    sortOption: $sortOption,
                    uniqueRanges: uniqueRanges,
                    onAddTap: onAddTap
                )

                SearchBar(
                    searchText: $searchText,
                    sortOption: $sortOption,
                    selectedFilter: $selectedFilter,
                    selectedRange: $selectedRange,
                    uniqueRanges: uniqueRanges
                )

                ProgressSection(
                    completedInt: progressInfo.completedInt,
                    totalInt: progressInfo.totalInt,
                    progress: progressInfo.progress
                )

                CompletionChart(store: store)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            let progressInfo: ProgressInfo = makeProgressInfo(from: store.mountains)

            MainContent(
                selectedFilter: $selectedFilter,
                selectedRange: $selectedRange,
                sortOption: $sortOption,
                searchText: $searchText,
                uniqueRanges: uniqueRanges,
                progressInfo: progressInfo,
                store: store,
                onAddTap: { showAddMountainSheet = true }
            )
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .onChange(of: selectedFilter) { _, newValue in
                if newValue == .range, selectedRange == nil {
                    selectedRange = uniqueRanges.first
                }
            }
            .onChange(of: sortOption) { _, newValue in
                defaultSortOptionRaw = newValue.rawValue
            }
            .onAppear {
                if let restored = SortOption.allCases.first(where: { $0.rawValue == defaultSortOptionRaw }) {
                    sortOption = restored
                }
            }
            .padding(.bottom, 8)
            
            MountainsList(
                filteredMountains: filteredMountains,
                store: store
            )
        }
        .safeAreaPadding(.top)
        .background(ContentViewBackground())
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddMountainSheet) {
            AddMountainView(store: store)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
