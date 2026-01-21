import SwiftUI
import Charts
import MapKit

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
                    
                    HStack {
                        Text("NH48")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape")
                                .foregroundStyle(.white)
                                .imageScale(.large)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.25), lineWidth: 1))
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
                        }
                        .accessibilityLabel("Settings")
                        
                        Spacer()
                        Button(action: {
                            showAddMountainSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .imageScale(.large)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.25), lineWidth: 1))
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
                        }
                        .accessibilityLabel("Add Mountain")
                    }
                    
                    Text("Welcome back!")
                        .font(.title2.weight(.semibold))
                        .tracking(0.5)
                        .foregroundStyle(.white.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Search bar moved here, below greeting
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)

                        TextField("Search mountains", text: $searchText)
                            .textFieldStyle(.plain)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)

                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .accessibilityLabel("Clear search")
                        }
                    }
                    .padding(10)
                    .background(.thinMaterial)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.white.opacity(0.15), lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Filter controls
                    VStack(spacing: 8) {
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(MountainFilter.allCases) { filter in
                                Text(label(for: filter))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    .tag(filter)
                            }
                        }
                        .pickerStyle(.segmented)

                        if selectedFilter == .range {
                            Menu {
                                Button("All Ranges") { selectedRange = nil }
                                ForEach(uniqueRanges, id: \.self) { range in
                                    Button(range) { selectedRange = range }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "map")
                                    Text(selectedRange ?? "Select Range")
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .minimumScaleFactor(0.8)
                                    Spacer(minLength: 0)
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(.thinMaterial)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(Color.white.opacity(0.15), lineWidth: 0.5)
                                )
                            }
                            .accessibilityLabel("Choose mountain range")
                        }
                        
                        // Sort segmented
                        Picker("Sort", selection: $sortOption) {
                            Text("Elev ↓").tag(SortOption.elevationDescending)
                            Text("Elev ↑").tag(SortOption.elevationAscending)
                            Text("Name").tag(SortOption.name)
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Progress")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(completedInt)/\(totalInt)")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white.opacity(0.9))
                        }

                        ProgressView(value: progress)
                            .tint(.white)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .shadow(radius: 1)

                        Text(String(format: "%.0f%% completed", progress.isFinite ? progress * 100 : 0))
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(Color.white.opacity(0.15), lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                    
                    if store.mountains.contains(where: { $0.completionDate != nil }) {
                        // Build cumulative completion points by day
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

                // List container with smooth transition
                VStack(spacing: 12) {
                    // Grabber for a subtle sheet-like transition
                    Capsule()
                        .fill(Color.white.opacity(0.35))
                        .frame(width: 36, height: 4)
                        .padding(.top, 10)

                    HStack {
                        Text("Mountains")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("\(filteredMountains.count) \(filteredMountains.count == 1 ? "result" : "results")")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 8)

                    LazyVStack(spacing: 12) {
                        if filteredMountains.isEmpty {
                            VStack(spacing: 6) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.secondary)
                                Text("No mountains match your filters")
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 24)
                        }
                        
                        ForEach(filteredMountains) { mountain in
                            NavigationLink(destination: MountainDetailView(mountain: mountain) { updatedMountain in
                                if let index = store.mountains.firstIndex(where: { $0.id == updatedMountain.id }) {
                                    store.mountains[index] = updatedMountain
                                    store.saveData()
                                }
                            }) {
                                MountainCardView(mountain: mountain) {
                                    if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                                        store.mountains[index].isCompleted.toggle()
                                        store.saveData()
                                    }
                                }
                                .padding(.horizontal, 4) // subtly smaller card footprint
                                .contextMenu {
                                    Button {
                                        if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                                            store.mountains[index].isCompleted.toggle()
                                            // Clear completion date if uncompleting
                                            if !store.mountains[index].isCompleted {
                                                store.mountains[index].completionDate = nil
                                            }
                                            store.saveData()
                                        }
                                    } label: {
                                        Label(mountain.isCompleted ? "Mark as Not Completed" : "Mark as Completed",
                                              systemImage: mountain.isCompleted ? "xmark.circle" : "checkmark.circle")
                                    }

                                    Button {
                                        if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                                            store.mountains[index].isCompleted = true
                                            store.mountains[index].completionDate = Date()
                                            store.saveData()
                                        }
                                    } label: {
                                        Label("Mark Completed Today", systemImage: "calendar.badge.checkmark")
                                    }

                                    if let lat = mountain.latitude, let lon = mountain.longitude {
                                        Button {
                                            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                            let placemark = MKPlacemark(coordinate: coord)
                                            let item = MKMapItem(placemark: placemark)
                                            item.name = mountain.name
                                            item.openInMaps()
                                        } label: {
                                            Label("Open in Maps", systemImage: "map")
                                        }
                                    }

                                    Button(role: .destructive) {
                                        if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                                            store.mountains.remove(at: index)
                                            store.saveData()
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                }
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.thinMaterial)
                )
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    LinearGradient(
                        colors: [Color.black.opacity(0.06), Color.black.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 12),
                    alignment: .top
                )
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: -2)
                .padding(.horizontal, 12)
                .padding(.top, -8)
            }
            .safeAreaPadding(.top)
            .background(
                ZStack {
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.blue.opacity(0.75), location: 0.0),
                            .init(color: Color.cyan.opacity(0.55), location: 0.45),
                            .init(color: Color.green.opacity(0.35), location: 1.0)
                        ]),
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                    RadialGradient(
                        colors: [Color.white.opacity(0.18), Color.clear],
                        center: .top,
                        startRadius: 0,
                        endRadius: 260
                    )
                    .blendMode(.overlay)
                    
                    Circle()
                        .fill(Color.cyan.opacity(0.12))
                        .frame(width: 176, height: 176)
                        .offset(x: 150, y: 100)
                        .blur(radius: 30)
                    
                    Circle()
                        .fill(Color.blue.opacity(0.10))
                        .frame(width: 88, height: 88)
                        .offset(x: 120, y: 100)
                        .blur(radius: 30)
                    
                    Circle()
                        .fill(Color.green.opacity(0.08))
                        .frame(width: 96, height: 96)
                        .offset(x: 50, y: 40)
                        .blur(radius: 30)
                    
                    LinearGradient(
                        colors: [Color.black.opacity(0.15), Color.clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .blendMode(.softLight)
                    
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .opacity(0.03)
                        .allowsHitTesting(false)
                }
                .ignoresSafeArea()
            )
            .task {
                // Determine if any mountains are missing usable images
                let hasMissing: Bool = store.mountains.contains { m in
                    guard let name = m.image else { return true }
                    // consider missing if neither a document image nor an asset image resolves
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
