import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var sortOption: SortOption
    @Binding var selectedFilter: MountainFilter
    @Binding var selectedRange: String?
    let uniqueRanges: [String]
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            TextField("Search 4,000-footers...", text: $searchText)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .foregroundStyle(.primary)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .accessibilityLabel("Clear search")
            }
            
            Divider()
                .frame(height: 18)
            
            Menu {
                Section("Sort By") {
                    Picker("Sort", selection: $sortOption) {
                        Text("Elevation ↓").tag(SortOption.elevationDescending)
                        Text("Elevation ↑").tag(SortOption.elevationAscending)
                        Text("Name (A-Z)").tag(SortOption.name)
                        Text("Completed First").tag(SortOption.completedFirst)
                    }
                }
                Section("Filter By") {
                    Button("All Mountains") { selectedFilter = .all }
                    Button("Completed") { selectedFilter = .completed }
                    Button("To Do") { selectedFilter = .notCompleted }
                    Menu("Mountain Range") {
                        Button("All Ranges") { selectedFilter = .range; selectedRange = nil }
                        ForEach(uniqueRanges, id: \.self) { range in
                            Button(range) { selectedFilter = .range; selectedRange = range }
                        }
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(.title3)
                    if selectedFilter != .all || selectedRange != nil {
                        Circle()
                            .fill(.blue)
                            .frame(width: 6, height: 6)
                    }
                }
                .foregroundStyle(.tint)
            }
            .accessibilityLabel("Filter and Sort Options")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)
        .padding(.horizontal)
    }
}
