import SwiftUI

struct ContentView: View {
    @StateObject private var store = MountainStore()
    @State private var searchText = ""
    @State private var showAddMountainSheet = false
    @State private var selectedRange: String? = nil
    
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
    
    @State private var selectedFilter: MountainFilter = .all
    
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
        
        return searched.sorted { $0.elevation > $1.elevation }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    
                    let completedInt = store.mountains.filter { $0.isCompleted }.count
                    let totalInt = store.mountains.count
                    
                    let completed = Double(completedInt)
                    let total = Double(totalInt)
                    
                    let progress = total > 0 ? completed / total : 0
                    
                    Text("Completed: \(completedInt)/\(totalInt)")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .center).bold()
                    
                    PieProgressView(progress: progress)
                        .frame(width: 150, height: 150)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
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
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 8) {
                        NavigationLink(destination: AllMountainsMapView(mountains: store.mountains)) {
                            Image(systemName: "map")
                                .imageScale(.medium)
                        }
                        .accessibilityLabel("Show Map")

                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        HStack(spacing: 6) {
                            TextField("Search mountains", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.vertical, 8)
                            
                            // Main filter menu
                            Menu {
                                ForEach(MountainFilter.allCases) { filter in
                                    Button(action: {
                                        selectedFilter = filter
                                    }) {
                                        Label(filter.rawValue,
                                              systemImage: selectedFilter == filter ? "checkmark" : "")
                                    }
                                }
                            } label: {
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                    .imageScale(.medium)
                                    .foregroundColor(.gray)
                            }
                            
                            // 👇 Show only when "Range" is selected
                            if selectedFilter == .range {
                                Picker("Range", selection: $selectedRange) {
                                    Text("All Ranges").tag(nil as String?)
                                    ForEach(uniqueRanges, id: \.self) { range in
                                        Text(range).tag(range as String?)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 160)
                            }
                        }
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .frame(width: 260)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAddMountainSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
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
