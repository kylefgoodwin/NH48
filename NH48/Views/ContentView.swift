import SwiftUI

struct ContentView: View {
    @StateObject private var store = MountainStore()
    @State private var searchText = ""
    @State private var showAddMountainSheet = false
    @State private var selectedRange: String? = nil
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @AppStorage("defaultSortOption") private var defaultSortOptionRaw: String = SortOption.elevationDescending.rawValue
    @AppStorage("hasFetchedImagesOnce") private var hasFetchedImagesOnce: Bool = false
    @AppStorage("lastMountainCount") private var lastMountainCount: Int = 0
    
    var uniqueRanges: [String] {
        Array(Set(store.mountains.map { $0.location })).sorted()
    }
    
    enum MountainFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case completed = "Completed"
        case notCompleted = "Not Completed"
        case range = "Mountain Range"
        
        var id: String { rawValue }
    }
    
    private func label(for filter: MountainFilter) -> String {
        if horizontalSizeClass == .compact {
            switch filter {
            case .all: return "All"
            case .completed: return "Done"
            case .notCompleted: return "To Do"
            case .range: return "Range"
            }
        } else {
            return filter.rawValue
        }
    }
    
    enum SortOption: String, CaseIterable, Identifiable {
        case elevationDescending = "Elevation ↓"
        case elevationAscending = "Elevation ↑"
        case name = "Name"
        case completedFirst = "Completed"
        var id: String { rawValue }
    }
    
    @State private var selectedFilter: MountainFilter = .all
    @State private var sortOption: SortOption = .elevationDescending
    
    var filteredMountains: [Mountain] {
        let baseList = store.mountains.filter { mountain in
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
        
        let searched = searchText.isEmpty
            ? baseList
            : baseList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        let sorted = searched.sorted {
            switch sortOption {
            case .elevationDescending:
                return $0.elevation > $1.elevation
            case .elevationAscending:
                return $0.elevation < $1.elevation
            case .name:
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            case .completedFirst:
                if $0.isCompleted != $1.isCompleted {
                    return $0.isCompleted && !$1.isCompleted
                }
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        }
        return sorted
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                let completedInt = store.mountains.filter { $0.isCompleted }.count
                let totalInt = store.mountains.count
                let completed = Double(completedInt)
                let total = Double(totalInt)
                let progress = total > 0 ? completed / total : 0
                
                VStack(spacing: 16) {
                    ContentViewHeader()
                    
                    Text("Welcome back!")
                        .font(.title2.weight(.semibold))
                        .tracking(0.5)
                        .foregroundStyle(.white.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    SearchBar(searchText: $searchText)
                    
                    FilterControls(
                        selectedFilter: $selectedFilter,
                        selectedRange: $selectedRange,
                        sortOption: $sortOption,
                        label: label,
                        uniqueRanges: uniqueRanges
                    )
                    
                    ProgressSection(
                        completedInt: completedInt,
                        totalInt: totalInt,
                        progress: progress
                    )
                    
                    CompletionChart(store: store)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .onChange(of: selectedFilter) { newValue in
                    if newValue == .range, selectedRange == nil {
                        selectedRange = uniqueRanges.first
                    }
                }
                .onChange(of: sortOption) { newValue in
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
            .task {
                let hasMissing: Bool = store.mountains.contains { m in
                    guard let name = m.image else { return true }
                    return ImageStore.loadImage(named: name) == nil && UIImage(named: name) == nil
                }
                if !hasFetchedImagesOnce || store.mountains.count > lastMountainCount || hasMissing {
                    await store.fetchMissingImagesFromWeb()
                    hasFetchedImagesOnce = true
                    lastMountainCount = store.mountains.count
                } else if lastMountainCount == 0 {
                    lastMountainCount = store.mountains.count
                }
            }
            .onChange(of: store.mountains.count) { newCount in
                if newCount > lastMountainCount {
                    Task {
                        await store.fetchMissingImagesFromWeb()
                        lastMountainCount = newCount
                    }
                }
            }
            .sheet(isPresented: $showAddMountainSheet) {
                AddMountainView(store: store)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
