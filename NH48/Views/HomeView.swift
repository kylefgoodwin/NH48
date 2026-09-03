import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: MountainStore
    @State private var searchText: String = ""
    @State private var selectedFilter: MountainFilter = .all
    @State private var selectedRange: String? = nil
    @State private var sortOption: SortOption = .elevationDescending
    @State private var showAddMountainSheet: Bool = false

    private var uniqueRanges: [String] {
        Array(Set(store.mountains.map { $0.location })).sorted()
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
                    VStack(spacing: 14) {
                        // Progress header
                        ProgressSection(completedInt: progressTuple.completed, totalInt: progressTuple.total, progress: progressTuple.progress)
                            .padding(.top)

                        // Filters
                        SearchBar(
                            searchText: $searchText,
                            sortOption: $sortOption,
                            selectedFilter: $selectedFilter,
                            selectedRange: $selectedRange,
                            uniqueRanges: uniqueRanges
                        )

                        // Grid
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(filteredMountains) { mountain in
                                NavigationLink(value: mountain) {
                                    MountainCardView(mountain: mountain) {
                                        store.toggleCompletion(for: mountain)
                                    }
                                    .environmentObject(store)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationDestination(for: Mountain.self) { mountain in
                MountainDetailView(mountain: mountain) { updatedMountain in
                    store.updateMountain(updatedMountain)
                }
            }
            .navigationTitle("NH48")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddMountainSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddMountainSheet) {
                AddMountainView(store: store)
            }
        }
    }
}

#Preview {
    let store = MountainStore()
    return HomeView()
        .environmentObject(store)
}
